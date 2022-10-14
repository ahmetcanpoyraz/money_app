import 'package:money_app/views/loan_application/loan_application_viewmodel.dart';
import 'package:money_app/views/pay/pay_viewmodel.dart';
import 'package:money_app/views/to_whom/to_whom_viewmodel.dart';
import 'package:money_app/views/top_up/top_up_viewmodel.dart';
import 'package:money_app/views/transaction_detail/transaction_detail_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../../views/transactions/transactions_viewmodel.dart';

class ProviderManager {
  static ProviderManager? _instance;
  static ProviderManager get instance {
    _instance ??= ProviderManager._init();
    return _instance!;
  }

  ProviderManager._init();

  List<SingleChildWidget> singleProvider = [
    ChangeNotifierProvider<TransactionsViewModel>(
      create: (_) => TransactionsViewModel(),
    ),
    ChangeNotifierProvider<PayViewModel>(
      create: (_) => PayViewModel(),
    ),
    ChangeNotifierProvider<TopUpViewModel>(
      create: (_) => TopUpViewModel(),
    ),
    ChangeNotifierProvider<ToWhomViewModel>(
      create: (_) => ToWhomViewModel(),
    ),
    ChangeNotifierProvider<LoanApplicationViewModel>(
      create: (_) => LoanApplicationViewModel(),
    ),
    ChangeNotifierProvider<TransactionDetailViewModel>(
      create: (_) => TransactionDetailViewModel(),
    ),
  ];
}
