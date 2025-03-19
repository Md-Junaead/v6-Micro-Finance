import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/screens/loan/loan_save.dart';
import 'package:v1_micro_finance/screens/loan/loan_view_model.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';

class LoanStatusScreen extends StatelessWidget {
  const LoanStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    final vm = context.watch<LoanViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('My Loans')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => LoanSaveScreen())),
        child: Icon(Icons.add),
      ),
      body: _buildBody(auth, vm),
    );
  }

  Widget _buildBody(AuthViewModel auth, LoanViewModel vm) {
    if (vm.isLoading) return CircularProgressIndicator();
    if (vm.errorMessage != null) return Text(vm.errorMessage!);

    return ListView.builder(
      itemCount: vm.loans.length,
      itemBuilder: (ctx, i) => ListTile(
        title: Text('${vm.loans[i].loanAmount}'),
        subtitle: Text('Status: ${vm.loans[i].status ?? 'Pending'}'),
        trailing: Text('Weekly: ${vm.loans[i].weeklyPay}'),
      ),
    );
  }
}
