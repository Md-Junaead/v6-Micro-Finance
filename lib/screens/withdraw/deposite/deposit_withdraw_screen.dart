// deposit_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/widgets/comon_appbar.dart';
import 'package:v1_micro_finance/screens/withdraw/deposite/deposit_withdraw_viewmodel.dart';

class DepositWithdrawScreen extends StatelessWidget {
  const DepositWithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CommonAppBar(title: "Deposit Withdraw"),
        body: Column(
          children: [
            const TabBar(
              labelColor: Color(0xFF06426D), // selected tab text color
              unselectedLabelColor:
                  Color(0xFF06426D), // unselected tab text color
              tabs: [
                Tab(text: 'Bank Transfer'),
                Tab(text: 'Crypto'),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  BankWithdrawalForm(),
                  CryptoWithdrawalForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BankWithdrawalForm extends StatelessWidget {
  const BankWithdrawalForm({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DepositWithdrawViewModel>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildInputField(
              controller: vm.bankControllers['accountNumber']!,
              label: 'Account Number',
              type: TextInputType.number,
            ),
            _buildInputField(
              controller: vm.bankControllers['bankName']!,
              label: 'Bank Name',
            ),
            _buildInputField(
              controller: vm.bankControllers['routingNumber']!,
              label: 'Routing Number',
              type: TextInputType.number,
            ),
            _buildInputField(
              controller: vm.bankControllers['swiftCode']!,
              label: 'Swift Code',
              type: TextInputType.number,
            ),
            _buildInputField(
              controller: vm.bankControllers['amount']!,
              label: 'Amount',
              type: TextInputType.number,
            ),
            _buildSubmitButton(
              context,
              'Submit Bank Withdrawal',
              vm.submitBankWithdrawal,
            ),
            if (vm.errorMessage != null) _buildErrorText(vm.errorMessage!),
          ],
        ),
      ),
    );
  }
}

class CryptoWithdrawalForm extends StatelessWidget {
  const CryptoWithdrawalForm({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DepositWithdrawViewModel>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCryptoTypeSelector(context),
            _buildInputField(
              controller: vm.cryptoData['walletId']!,
              label: 'Wallet ID',
            ),
            _buildInputField(
              controller: vm.cryptoData['amount']!,
              label: 'Amount',
              type: TextInputType.number,
            ),
            _buildSubmitButton(
              context,
              'Submit Crypto Withdrawal',
              vm.submitCryptoWithdrawal,
            ),
            if (vm.errorMessage != null) _buildErrorText(vm.errorMessage!),
          ],
        ),
      ),
    );
  }

  Widget _buildCryptoTypeSelector(BuildContext context) {
    final vm = context.watch<DepositWithdrawViewModel>();
    return Row(
      children: [
        Expanded(
          child: RadioListTile<String>(
            title: const Text('BTC'),
            value: 'BTC',
            groupValue: vm.cryptoData['type'],
            onChanged: (value) => vm.setCryptoType(value!),
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            title: const Text('USDT'),
            value: 'USDT',
            groupValue: vm.cryptoData['type'],
            onChanged: (value) => vm.setCryptoType(value!),
          ),
        ),
      ],
    );
  }
}

// Common UI components
Widget _buildInputField({
  required TextEditingController controller,
  required String label,
  TextInputType type = TextInputType.text,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: type,
      validator: (value) => value?.isEmpty ?? true ? 'Required field' : null,
    ),
  );
}

Widget _buildSubmitButton(
    BuildContext context, String text, VoidCallback onPressed) {
  final vm = context.watch<DepositWithdrawViewModel>();
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: ElevatedButton(
      onPressed: vm.isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        backgroundColor: Color(0xFF06426D),
      ),
      child: vm.isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(text, style: const TextStyle(color: Colors.white)),
    ),
  );
}

Widget _buildErrorText(String message) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Text(
      message,
      style: const TextStyle(color: Colors.red, fontSize: 16),
    ),
  );
}
