import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_app/core/constants/navigation_constant.dart';
import 'package:money_app/core/init/navigation/navigation_service.dart';
import 'package:money_app/core/models/transaction_model.dart';
import 'package:provider/provider.dart';
import '../../../core/base/base_viewmodel/base_viewmodel.dart';
import '../../core/components/global_widgets/alertdialog/custom_alertdialog.dart';
import '../transactions/transactions_viewmodel.dart';

class TransactionDetailViewModel extends BaseViewModel {
  bool isInit = false;
  late TransactionModel transactionModel;
  bool? switchValue;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  Future<void> init() async {
    if (transactionModel.isPayment) {
      switchValue = transactionModel.repeatingPayment;
    }
    if (!isInit) {
      changeStatus();
      isInit = !isInit;
    }
  }

  String convertDateFormat(DateTime dateTime) {
    return "${dateTime.day} ${DateFormat.MMMM().format(dateTime).toUpperCase()} ${DateFormat.y().add_jm().format(dateTime)}";
  }

  Future<void> repeatingPayment(bool value) async {
    transactionModel.repeatingPayment = value;
    Provider.of<TransactionsViewModel>(context!, listen: false)
        .transactionList
        .firstWhere((element) => element.id == transactionModel.id)
        .repeatingPayment = value;
    switchValue = value;
    if (value == true) {
      Provider.of<TransactionsViewModel>(context!, listen: false)
          .transactionList
          .insert(
              0,
              TransactionModel(
                id: DateTime.now().toString(),
                createdAt: DateTime.now(),
                isPayment: true,
                name: transactionModel.name,
                money: transactionModel.money,
                repeatingPayment: false,
              ));
      Provider.of<TransactionsViewModel>(context!, listen: false).money -=
          transactionModel.money;
      NavigationService.instance
          .navigateToPageClear(path: NavigationConstants.transactionsPage);
    }
    notifyListeners();
  }

  Future<void> splitThisBill() async {
    transactionModel.money = transactionModel.money / 2;
    Provider.of<TransactionsViewModel>(context!, listen: false)
        .transactionList
        .firstWhere((element) => element.id == transactionModel.id)
        .money = transactionModel.money;

    Provider.of<TransactionsViewModel>(context!, listen: false)
        .transactionList
        .insert(
            0,
            TransactionModel(
              id: DateTime.now().toString(),
              createdAt: DateTime.now(),
              isPayment: false,
              name: "topUp".tr(),
              money: transactionModel.money,
            ));
    Provider.of<TransactionsViewModel>(context!, listen: false).money +=
        transactionModel.money;
    NavigationService.instance
        .navigateToPageClear(path: NavigationConstants.transactionsPage);
    notifyListeners();
  }

  void showAlertDialogForHelp() {
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          titleColor: Theme.of(context).primaryColor,
          title: "info".tr(),
          message: "help".tr(),
          butonColor: Theme.of(context).primaryColor,
          butonText: "okey".tr(),
          onButtonPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
