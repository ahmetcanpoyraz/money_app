import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_app/core/constants/navigation_constant.dart';
import 'package:money_app/core/init/navigation/navigation_service.dart';
import 'package:money_app/core/models/transaction_model.dart';
import 'package:money_app/core/repositories/generate_random_number_repository.dart';
import 'package:money_app/views/transactions/transactions_view.dart';
import 'package:money_app/views/transactions/transactions_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../core/base/base_viewmodel/base_viewmodel.dart';
import '../../core/components/global_widgets/alertdialog/custom_alertdialog.dart';


class LoanApplicationViewModel extends BaseViewModel {
  bool isInit = false;
   TextEditingController monthlySalaryController = TextEditingController();
   TextEditingController monthlyExpensesController = TextEditingController();
   TextEditingController loanAmountController = TextEditingController();
   TextEditingController loanTermController = TextEditingController();
   bool switchAdaptiveValue = false;
   bool isAppliedBefore = false;
   bool isApproved = false;
   bool isWillListen = false;
   bool rule1 = false;
   bool rule2 = false;
   bool rule3 = false;
   bool rule4 = false;
   bool rule5 = false;
   late int generatedNumber;
  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  Future<void> init() async {
    await generateRandomNumber();
    if (!isInit) {
      changeStatus();
      isInit = !isInit;
    }
  }

  Future<void> changeSwitchAdaptiveValue(bool value) async{
    switchAdaptiveValue = value;
    notifyListeners();
  }

  Future<void> generateRandomNumber() async{
    GenerateRandomNumberRepository.instance.getGeneratedRandomNumber().then((value) {
      print("generated number : ${value.data[0]}");
      generatedNumber = value.data[0];
    });
  }

  Future<void> runLoanDecisionService() async{
    if(isAppliedBefore == false){
      isAppliedBefore = true;
      if(generatedNumber > 50){
        rule1 = true;
      }
      if(Provider.of<TransactionsViewModel>(context!,listen: false).money > 1000){
        rule2 = true;
      }
      if(int.parse(monthlySalaryController.text) > 1000){
        rule3 = true;
      }
      if(int.parse(monthlyExpensesController.text) < (int.parse(monthlySalaryController.text) / 3)){
        rule4 = true;
      }
      if((int.parse(loanAmountController.text) / int.parse(loanTermController.text)) < (int.parse(monthlySalaryController.text) / 3)){
        rule5 = true;
      }
      if(rule1 && rule2 && rule3 && rule4 && rule5){
        isApproved = true;
        return showAlertForApproved();
      }
      if((!rule1 || !rule2) && (rule3 && rule5)){
        isWillListen = true;
       return showAlertForDeclined();
      }else{
        isWillListen = false;
        return showAlertForDeclined();
      }

    }else{
      if(!isApproved){
        if(isWillListen){
          if(generatedNumber > 50){
            rule1 = true;
          }
          if(Provider.of<TransactionsViewModel>(context!,listen: false).money > 1000){
            rule2 = true;
          }
          if(rule1 && rule2 && rule3 && rule4 && rule5){
            isApproved = true;
            return showAlertForApproved();
          }
        }else{
          return showAlertForDeclined();
        }
      }else{
        return showAlertForAppliedBefore();
      }
    }
  }

  Future<void> showAlertForAcceptTermAndConditions() async{
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          titleColor: Theme.of(context).primaryColor,
          title: "info".tr(),
          message: "acceptTerms".tr(),
          butonColor: Theme.of(context).primaryColor,
          butonText: "okey".tr(),
          onButtonPressed: (){
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
  Future<void> showAlertForEmptyData() async{
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          titleColor: Theme.of(context).primaryColor,
          title: "info".tr(),
          message: "enterValues".tr(),
          butonColor: Theme.of(context).primaryColor,
          butonText: "okey".tr(),
          onButtonPressed: (){
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
  Future<void> showAlertForDeclined() async{
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          titleColor: Colors.red,
          title: "declined".tr(),
          message: "declinedMessage".tr(),
          butonColor: Colors.red,
          butonText: "okey".tr(),
          onButtonPressed: (){
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> showAlertForApproved() async{
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          titleColor: Colors.green,
          title: "approved".tr(),
          message: "approvedMessage".tr(),
          butonColor: Colors.green,
          butonText: "okey".tr(),
          onButtonPressed: (){
            Provider.of<TransactionsViewModel>(context,listen: false).money +=  double.parse(loanAmountController.text);
            Provider.of<TransactionsViewModel>(context,listen: false).transactionList.insert(
                0,
                TransactionModel(
                    id: DateTime.now().toString(),
                    createdAt: DateTime.now(),
                    isPayment: false,
                    name: "Loan",
                    money: double.parse(loanAmountController.text)));

            NavigationService.instance.navigateToPageClear(path: NavigationConstants.transactionsPage);
          },
        );
      },
    );
  }

  Future<void> showAlertForAppliedBefore() async{
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          titleColor: isApproved ? Colors.green : Colors.red,
          title: isApproved ? "approved".tr() : "declined".tr() ,
          message: "appliedBefore".tr(),
          butonColor: isApproved ? Colors.green : Colors.red,
          butonText: "okey".tr(),
          onButtonPressed: (){
              Navigator.of(context).pop();
          },
        );
      },
    );
  }



}
