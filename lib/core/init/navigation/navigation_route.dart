import 'package:flutter/material.dart';
import 'package:money_app/views/loan_application/loan_application_view.dart';
import 'package:money_app/views/pay/pay_view.dart';
import 'package:money_app/views/to_whom/to_whom_view.dart';
import 'package:money_app/views/top_up/top_up_view.dart';
import 'package:money_app/views/transaction_detail/transaction_detail_view.dart';
import '../../../views/transactions/transactions_view.dart';
import '../../constants/navigation_constant.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.defaultPage:
        return normalNavigate(
            const TransactionsView(), NavigationConstants.defaultPage);
      case NavigationConstants.transactionsPage:
        return animetedNavigate(const TransactionsView(), NavigationConstants.transactionsPage);
      case NavigationConstants.payPage:
        return animetedNavigate(const PayView(), NavigationConstants.payPage);
      case NavigationConstants.topUpPage:
        return animetedNavigate(const TopUpView(), NavigationConstants.topUpPage);
      case NavigationConstants.toWhomPage:
        return animetedNavigate(const ToWhomView(), NavigationConstants.toWhomPage);
      case NavigationConstants.transactionDetailPage:
        return animetedNavigate(const TransactionDetailView(), NavigationConstants.transactionDetailPage);
      case NavigationConstants.loanApplicationPage:
        return animetedNavigate(const LoanApplicationView(), NavigationConstants.loanApplicationPage);

      //--DEFAULT--//
      default:
        return MaterialPageRoute(
          builder: (context) => const Text("Not Found"),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, String pageName,
      {Object? data}) {
    return MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(name: pageName, arguments: data));
  }

  PageRouteBuilder animetedNavigate(Widget widget, String pageName) {
    return PageRouteBuilder(
      settings: RouteSettings(name: pageName),
      transitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (context, animation1, animation2) => widget,
      transitionsBuilder: (context, animation1, animation2, child) {
        return FadeTransition(opacity: animation1, child: child);
      },
    );
  }
}
