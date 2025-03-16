import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/widgets/comon_appbar.dart';
import 'package:v1_micro_finance/screens/loan/loan_model.dart';
import 'package:v1_micro_finance/screens/loan/loan_view_model.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';

class LoanStatusScreen extends StatelessWidget {
  const LoanStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final loanViewModel = Provider.of<LoanViewModel>(context);

    if (authViewModel.user == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (loanViewModel.loans.isEmpty && !loanViewModel.isLoading) {
      loanViewModel.fetchLoans(authViewModel.user!.id);
    }

    return Scaffold(
      appBar: CommonAppBar(title: "Loan Status"),
      body: loanViewModel.isLoading
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                backgroundColor: Colors.blue.shade100,
              ),
            )
          : loanViewModel.errorMessage != null
              ? Center(child: Text(loanViewModel.errorMessage!))
              : ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: loanViewModel.loans.length,
                  itemBuilder: (context, index) {
                    Loan loan = loanViewModel.loans[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(15),
                        leading: Icon(
                          Icons.money_off,
                          color: Colors.green.shade600,
                          size: 40,
                        ),
                        title: Text(
                          "Amount: ${loan.loanAmount}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          "Status: ${loan.status}",
                          style: TextStyle(
                            fontSize: 16,
                            color: loan.status == "Approved"
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue.shade600,
                        ),
                        onTap: () {
                          // You can add a navigation action here if needed
                        },
                      ),
                    );
                  },
                ),
    );
  }
}

// // loan_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:v1_micro_finance/configs/widgets/comon_appbar.dart';
// import 'package:v1_micro_finance/screens/loan/loan_model.dart';
// import 'package:v1_micro_finance/screens/loan/loan_view_model.dart';
// import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';

// class LoanStatusScreen extends StatelessWidget {
//   const LoanStatusScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final authViewModel = Provider.of<AuthViewModel>(context);
//     final loanViewModel = Provider.of<LoanViewModel>(context);

//     if (authViewModel.user == null) {
//       return Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (loanViewModel.loans.isEmpty && !loanViewModel.isLoading) {
//       loanViewModel.fetchLoans(authViewModel.user!.id);
//     }

//     return Scaffold(
//       appBar: CommonAppBar(title: "Loan Status"),
//       body: loanViewModel.isLoading
//           ? Center(child: CircularProgressIndicator())
//           : loanViewModel.errorMessage != null
//               ? Center(child: Text(loanViewModel.errorMessage!))
//               : ListView.builder(
//                   itemCount: loanViewModel.loans.length,
//                   itemBuilder: (context, index) {
//                     Loan loan = loanViewModel.loans[index];
//                     return ListTile(
//                       title: Text("Amount: ${loan.loanAmount}"),
//                       subtitle: Text("Status: ${loan.status}"),
//                     );
//                   },
//                 ),
//     );
//   }
// }
