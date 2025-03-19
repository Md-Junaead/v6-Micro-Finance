// Work well to get single updated Balance for unique user
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/screens/deposit/balance_view_model.dart';
import 'balance_model.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch balances when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BalanceViewModel>(context, listen: false).fetchBalances();
    });
  }

  @override
  Widget build(BuildContext context) {
    final balanceViewModel = Provider.of<BalanceViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Balance Overview'),
      ),
      body: _buildBody(balanceViewModel),
    );
  }

  Widget _buildBody(BalanceViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.errorMessage != null) {
      return Center(
        child: Text(
          viewModel.errorMessage!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (viewModel.balances.isEmpty) {
      return const Center(child: Text('No balance history found'));
    }

    // Changed: Instead of a ListView.builder, display only the last card
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: _buildBalanceCard(viewModel
          .balances.last), // Changed to show only the last balance card
    );
  }

  Widget _buildBalanceCard(Balance balance) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              balance.userRegistration.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Deposit Balance', '${balance.dipositB} BDT'),
            _buildInfoRow('Active Package', balance.packages),
            _buildInfoRow('Current Profit', '${balance.profitB}%'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

// Work fine to get all deposit history for all user
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:v1_micro_finance/screens/deposit/balance_view_model.dart';
// import 'balance_model.dart';

// class BalanceScreen extends StatefulWidget {
//   const BalanceScreen({super.key});

//   @override
//   State<BalanceScreen> createState() => _BalanceScreenState();
// }

// class _BalanceScreenState extends State<BalanceScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch balances when screen initializes
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<BalanceViewModel>(context, listen: false).fetchBalances();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final balanceViewModel = Provider.of<BalanceViewModel>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Balance Overview'),
//       ),
//       body: _buildBody(balanceViewModel),
//     );
//   }

//   Widget _buildBody(BalanceViewModel viewModel) {
//     if (viewModel.isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (viewModel.errorMessage != null) {
//       return Center(
//         child: Text(
//           viewModel.errorMessage!,
//           style: const TextStyle(color: Colors.red),
//         ),
//       );
//     }

//     if (viewModel.balances.isEmpty) {
//       return const Center(child: Text('No balance history found'));
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: viewModel.balances.length,
//       itemBuilder: (context, index) {
//         final balance = viewModel.balances[index];
//         return _buildBalanceCard(balance);
//       },
//     );
//   }

//   Widget _buildBalanceCard(Balance balance) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               balance.userRegistration.name,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),
//             _buildInfoRow('Deposit Balance', '${balance.dipositB} BDT'),
//             _buildInfoRow('Active Package', balance.packages),
//             _buildInfoRow('Current Profit', '${balance.profitB}%'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(color: Colors.grey),
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               fontWeight: FontWeight.w500,
//               color: Colors.blue,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
