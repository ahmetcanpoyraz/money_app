import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_app/core/models/transaction_model.dart';
import 'package:money_app/views/transactions/transactions_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../core/base/base_viewmodel/base_viewmodel.dart';
import '../../core/components/global_widgets/alertdialog/custom_alertdialog.dart';
import '../../core/constants/navigation_constant.dart';
import '../../core/init/navigation/navigation_service.dart';

class TopUpViewModel extends BaseViewModel {
  bool isInit = false;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController intEditingController = TextEditingController();
  TextEditingController decimalEditingController = TextEditingController();
  late FocusNode intFocusNode;
  late FocusNode decimalFocusNode;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  Future<void> init() async {
    textEditingController.text = "0.00";
    intEditingController.text = "0";
    decimalEditingController.text = "00";
    intFocusNode = FocusNode();
    decimalFocusNode = FocusNode();
    FocusScope.of(context!).requestFocus(intFocusNode);
    if (!isInit) {
      changeStatus();
      isInit = !isInit;
    }
  }

  @override
  void dispose() {
    intFocusNode.dispose();
    decimalFocusNode.dispose();
    super.dispose();
  }

  onTapSpace() {
    FocusScope.of(context!).unfocus();
    FocusScope.of(context!).focusedChild?.unfocus();
    if (intEditingController.text.isEmpty) {
      intEditingController.text = "0";
    }
    if (decimalEditingController.text.isEmpty) {
      decimalEditingController.text = "00";
    }
  }

  void onTopUpButtonPress() async {
    //FocusScope.of(context!).unfocus();
   // FocusScope.of(context!).focusedChild?.unfocus();
    if (intEditingController.text.isEmpty) {
      intEditingController.text = "0";
    }
    if (decimalEditingController.text.isEmpty) {
      decimalEditingController.text = "00";
    }
    if (intEditingController.text != "0" &&
        (decimalEditingController.text != "0" ||
            decimalEditingController.text != "00")) {
      String temp =
          "${intEditingController.text}.${decimalEditingController.text}";
      Provider.of<TransactionsViewModel>(context!, listen: false).money +=
          double.parse(temp);
      Provider.of<TransactionsViewModel>(context!, listen: false)
          .transactionList
          .insert(
              0,
              TransactionModel(
                id: DateTime.now().toString(),
                money: double.parse(temp),
                isPayment: false,
                createdAt: DateTime.now(),
                name: "topUp".tr(),
              ));
      NavigationService.instance
          .navigateToPageClear(path: NavigationConstants.transactionsPage);
    } else {
      showAlertForGreaterThan0();
    }
  }

  Future<void> showAlertForGreaterThan0() async {
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          titleColor: Theme.of(context).primaryColor,
          title: "info".tr(),
          message: "greaterThan0".tr(),
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
