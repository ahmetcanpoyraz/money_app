import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_app/core/models/transaction_model.dart';
import 'package:money_app/views/transactions/transactions_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../core/base/base_viewmodel/base_viewmodel.dart';
import '../../core/components/global_widgets/alertdialog/custom_alertdialog.dart';
import '../../core/constants/navigation_constant.dart';
import '../../core/init/navigation/navigation_service.dart';

class ToWhomViewModel extends BaseViewModel {
  bool isInit = false;
  late TextEditingController textEditingController;
  late double howMuchPay;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  Future<void> init() async {
    textEditingController = TextEditingController();

    if (!isInit) {
      changeStatus();
      isInit = !isInit;
    }
  }

  onPayButtonPress() async {
    if (textEditingController.text.isEmpty ||
        textEditingController.text.trim() == "") {
      showAlertForNotEmpty();
    } else {
      if (Provider.of<TransactionsViewModel>(context!, listen: false).money <
          howMuchPay) {
        showAlertForCannotPay();
      } else {
        FocusScope.of(context!).unfocus();
        Provider.of<TransactionsViewModel>(context!, listen: false)
            .transactionList
            .insert(
                0,
                TransactionModel(
                    id: DateTime.now().toString(),
                    createdAt: DateTime.now(),
                    isPayment: true,
                    name: textEditingController.text,
                    money: howMuchPay));
        Provider.of<TransactionsViewModel>(context!, listen: false).money -=
            howMuchPay;
        NavigationService.instance
            .navigateToPageClear(path: NavigationConstants.transactionsPage);
      }
    }
  }

  Future<void> showAlertForNotEmpty() async {
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          titleColor: Theme.of(context).primaryColor,
          title: "info".tr(),
          message: "towhomNotempty".tr(),
          butonColor: Theme.of(context).primaryColor,
          butonText: "okey".tr(),
          onButtonPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> showAlertForCannotPay() async {
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          titleColor: Theme.of(context).primaryColor,
          title: "info".tr(),
          message: "cannotPay".tr(),
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
