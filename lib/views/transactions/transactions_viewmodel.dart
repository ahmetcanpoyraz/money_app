import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../core/base/base_viewmodel/base_viewmodel.dart';
import '../../core/models/transaction_model.dart';

class TransactionsViewModel extends BaseViewModel {
  String? selectedValue;
  bool isInit = false;
  double money = 150.25;
  List<TransactionModel> transactionList = [
    TransactionModel(id:DateTime.now().toString(),name: "eBay",createdAt: DateTime.now(), isPayment: true ,money: 32.00,repeatingPayment: false),
    TransactionModel(id:DateTime.now().toString(),name: "Merton Council",createdAt: DateTime.now(), isPayment: true ,money: 65.00,repeatingPayment: false),
    TransactionModel(id:DateTime.now().toString(),name: "Top up",createdAt: DateTime.now(), isPayment: false ,money: 150.00),
    TransactionModel(id:DateTime.now().toString(),name: "Amazon",createdAt: DateTime.now().subtract(const Duration(days: 1)), isPayment: true ,money: 32.00,repeatingPayment: false),
    TransactionModel(id:DateTime.now().toString(),name: "John Snow",createdAt: DateTime.now().subtract(const Duration(days: 1)), isPayment: true ,money: 1400.00,repeatingPayment: false),
    TransactionModel(id:DateTime.now().toString(),name: "Top Up",createdAt: DateTime.now().subtract(const Duration(days: 1)), isPayment: false ,money: 200.00)
  ];
  List<TransactionModel> todayTransactionList = [];
  List<TransactionModel> yesterdayTransactionList = [];

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  Future<void> init() async {
    await fetchLanguage();
    await getTodayTransactionsList();
    await getYesterdayTransactionsList();

    if (!isInit) {
      changeStatus();
      isInit = !isInit;
    }
  }


  Future<void>  getTodayTransactionsList() async{
   todayTransactionList = transactionList.where((element) => calculateDifference(element.createdAt) == 0).toList();
   notifyListeners();
  }

  Future<void>  getYesterdayTransactionsList() async {
    yesterdayTransactionList = transactionList.where((element) => calculateDifference(element.createdAt) == -1).toList();
    notifyListeners();
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }

  Future<void> fetchLanguage() async {
    var box = Hive.box('langBox');
    if(box.get('langSelected') != null){
      String langSelected = box.get('langSelected');
      if(langSelected == "tr"){
        context?.setLocale(const Locale('tr', 'TR'));
      }
      if(langSelected == "en"){
        context?.setLocale(const Locale('en', 'US'));
      }
    }
  }

  Future<void> changeSelectedValue(String value) async {
    var box = Hive.box('langBox');
    if(value == "tr"){
      box.put('langSelected', 'tr');
      context!.setLocale(const Locale('tr', 'TR'));
    }
    if(value == 'en'){
      box.put('langSelected', 'en');
      context!.setLocale(const Locale('en', 'US'));
    }
    selectedValue = value;
    notifyListeners();
  }


  
}
