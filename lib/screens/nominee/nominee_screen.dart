import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/widgets/comon_appbar.dart';
import 'package:v1_micro_finance/screens/nominee/nominee_save_screen.dart';
import 'package:v1_micro_finance/screens/nominee/nominee_update_screen.dart';
import 'package:v1_micro_finance/screens/nominee/nominee_viewmodel.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';

class NomineeScreen extends StatefulWidget {
  const NomineeScreen({super.key});

  @override
  State<NomineeScreen> createState() => _NomineeScreenState();
}

class _NomineeScreenState extends State<NomineeScreen> {
  @override
  void initState() {
    super.initState();
    // Defer the fetchNominees call until after build completes:
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<AuthViewModel>();
      final nomineeVM = context.read<NomineeViewModel>();
      if (auth.user != null) {
        nomineeVM.fetchNominees(auth.user!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    final nomineeVM = context.watch<NomineeViewModel>();

    return Scaffold(
      appBar: CommonAppBar(title: "Nominee"),
      floatingActionButton: nomineeVM.nominees.isEmpty
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NomineeSaveScreen()),
              ),
              child: const Icon(Icons.add),
            )
          : ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UpdateNomineeScreen()),
              ),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
              ),
              child: const Icon(Icons.edit),
            ),
      body: _buildBody(auth, nomineeVM),
    );
  }

  Widget _buildBody(AuthViewModel auth, NomineeViewModel vm) {
    if (auth.user == null) {
      return const Center(child: Text('Please login'));
    }
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (vm.errorMessage != null) {
      return Center(child: Text(vm.errorMessage!));
    }
    if (vm.nominees.isEmpty) {
      return const Center(child: Text('No nominees found'));
    }

    return ListView.builder(
      itemCount: vm.nominees.length,
      itemBuilder: (context, index) {
        final n = vm.nominees[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${n.name}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Relationship: ${n.relationship}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 4),
                Text('Cell: ${n.cellNo}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 4),
                Text('Email: ${n.email}', style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
        );
      },
    );
  }
}
