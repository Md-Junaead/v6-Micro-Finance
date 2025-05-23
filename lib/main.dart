import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/routes/routes.dart';
import 'package:v1_micro_finance/configs/routes/routes_name.dart';
import 'package:v1_micro_finance/configs/viewmodels/reg_view_model.dart';
import 'package:v1_micro_finance/screens/deposit/balance_view_model.dart';
import 'package:v1_micro_finance/screens/loan/loan_list_viewmodel.dart';
import 'package:v1_micro_finance/screens/loan/loan_view_model.dart';
import 'package:v1_micro_finance/screens/nominee/nominee_viewmodel.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';
import 'package:v1_micro_finance/screens/withdraw/deposite/deposit_withdraw_viewmodel.dart';
import 'package:v1_micro_finance/screens/withdraw/profit/profit_withdraw_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => UserRegistrationViewModel()),
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => NomineeViewModel()),
        ChangeNotifierProvider(create: (_) => LoanViewModel()),
        ChangeNotifierProvider(create: (_) => BalanceViewModel()),
        ChangeNotifierProvider(create: (_) => LoanListViewModel()),
        ChangeNotifierProvider(create: (_) => DepositWithdrawViewModel()),
        ChangeNotifierProvider(create: (_) => ProfitWithdrawViewmodel())
      ],
      child: MicroFinance(),
    ),
  );
}

class MicroFinance extends StatelessWidget {
  const MicroFinance({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FINSYS',
      // flutter build apk --build-name=1.0 --build-number=1
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:
            Color(0xFFFEF7FF), // Set background color globally

        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF06426D), // Set AppBar color globally
        ),
      ),
      // This is the initial route indicating from where our app will start
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.generateRoute, // Route generator for navigation
    );
  }
}
