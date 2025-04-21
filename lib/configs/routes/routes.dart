import 'package:flutter/material.dart';
import 'package:v1_micro_finance/configs/routes/routes_name.dart';
import 'package:v1_micro_finance/screens/admin/admin.dart';
import 'package:v1_micro_finance/screens/dashboard/check_balance_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/deposit_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/packages_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/policies.dart';
import 'package:v1_micro_finance/screens/dashboard/quick_loan_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/referrals_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/withdraw_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/help_screen.dart';
import 'package:v1_micro_finance/screens/deposit/balance_save.dart';
import 'package:v1_micro_finance/screens/deposit/balance_screen.dart';
import 'package:v1_micro_finance/screens/loan/loan_status_screen.dart';
import 'package:v1_micro_finance/screens/loan/pay_emi_screen.dart';
import 'package:v1_micro_finance/screens/auth/login_screen.dart';
import 'package:v1_micro_finance/screens/nominee/nominee_save_screen.dart';
import 'package:v1_micro_finance/screens/nominee/nominee_screen.dart';
import 'package:v1_micro_finance/screens/policies/about_us.dart';
import 'package:v1_micro_finance/screens/policies/beneficiary_funds.dart';
import 'package:v1_micro_finance/screens/policies/loan_policy.dart';
import 'package:v1_micro_finance/screens/policies/privacy_policy.dart';
import 'package:v1_micro_finance/screens/policies/withdrawal_policy.dart';
import 'package:v1_micro_finance/screens/profile/edit_profile_screen.dart';
import 'package:v1_micro_finance/screens/auth/forgot_password.dart';
import 'package:v1_micro_finance/screens/bottom/home_screen.dart';
import 'package:v1_micro_finance/screens/auth/signup_screen.dart';
import 'package:v1_micro_finance/screens/onBord/splash_screen.dart';
import 'package:v1_micro_finance/screens/bottom/statement_screen.dart';
import 'package:v1_micro_finance/screens/auth/verification.dart';
import 'package:v1_micro_finance/screens/onBord/on_board_screen.dart';
import 'package:v1_micro_finance/screens/signin/user_info_screen.dart';
import 'package:v1_micro_finance/screens/withdraw/deposite/deposit_withdraw_screen.dart';
import 'package:v1_micro_finance/screens/withdraw/loan/loan_bank.dart';
import 'package:v1_micro_finance/screens/withdraw/loan/loan_crypto.dart';
import 'package:v1_micro_finance/screens/withdraw/loan/loan_gateway.dart';
import 'package:v1_micro_finance/screens/withdraw/profit/profit_withdraw_screen.dart';
import 'package:v1_micro_finance/test/test.dart';
import 'package:v1_micro_finance/configs/widgets/app_drawer.dart';
import 'package:v1_micro_finance/configs/widgets/bottom_nav_bar.dart';
import 'package:v1_micro_finance/screens/bottom/notification.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
//TestScreen routes name

      case RoutesName.testScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => TestScreen());

      case RoutesName.balanceScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => BalanceScreen());

      case RoutesName.balanceSaveScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => BalanceSaveScreen());

//SplashScreen routes name

      case RoutesName.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen());
      case RoutesName.startedScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => StartedScreen());

//Admin routes name

      case RoutesName.adminDashboard:
        return MaterialPageRoute(
            builder: (BuildContext context) => AdminDashboard());

//Auth Screen routes name

      case RoutesName.loginScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());

      case RoutesName.userRegistrationScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => UserRegistrationScreen());

      case RoutesName.forgotPasswordScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => ForgotPasswordScreen());

      case RoutesName.verificationScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => VerificationScreen());

//AppDrawer routes name
      case RoutesName.appDrawer:
        return MaterialPageRoute(
            builder: (BuildContext context) => AppDrawer());

      //Bottom routes name
      case RoutesName.notificationScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => NotificationScreen());

//BottomNavBar routes name

      case RoutesName.homeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());
      case RoutesName.statementScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => StatementScreen());

      case RoutesName.bottomNavBar:
        return MaterialPageRoute(
            builder: (BuildContext context) => BottomNavBar());

//Dashboard routes name

      case RoutesName.depositScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => DepositScreen());

      case RoutesName.checkBalanceScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => CheckBalanceScreen());
      case RoutesName.withDrawType:
        return MaterialPageRoute(
            builder: (BuildContext context) => WithDrawType());

      case RoutesName.referralsScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => ReferralsScreen());

      case RoutesName.quickLoanScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => QuickLoanScreen());

      case RoutesName.helpScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => HelpScreen());

      case RoutesName.packagesScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => PackagesScreen());

//User Profile routes name
      case RoutesName.editProfileScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => EditProfileScreen());

      case RoutesName.userInfoScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => UserInfoScreen());

      case RoutesName.nomineeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => NomineeScreen());

      case RoutesName.nomineeSaveScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => NomineeSaveScreen());

//Loan Routes Name LoanSaveScreen

      case RoutesName.loanStatusScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoanStatusScreen());

      case RoutesName.payEmiScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => PayEmiScreen());

//Loan Payment Routes Name

      case RoutesName.loanGateway:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoanGateway());

      case RoutesName.loanBank:
        return MaterialPageRoute(builder: (BuildContext context) => LoanBank());

      case RoutesName.loanCrypto:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoanCrypto());

//Profit Payment Routes Name

      case RoutesName.profitWithdrawScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => ProfitWithdrawScreen());
//Policies Routes Name
      case RoutesName.policies:
        return MaterialPageRoute(builder: (BuildContext context) => Policies());

      case RoutesName.aboutUs:
        return MaterialPageRoute(builder: (BuildContext context) => AboutUs());

      case RoutesName.beneficiaryFunds:
        return MaterialPageRoute(
            builder: (BuildContext context) => BeneficiaryFunds());

      case RoutesName.loanPolicy:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoanPolicy());

      case RoutesName.privacyPolicy:
        return MaterialPageRoute(
            builder: (BuildContext context) => PrivacyPolicy());

      case RoutesName.withdrawalPolicy:
        return MaterialPageRoute(
            builder: (BuildContext context) => WithdrawalPolicy());

      //Withdraw Screen Routes

      case RoutesName.depositWithdrawScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => DepositWithdrawScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
