import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/widgets/comon_appbar.dart';
import 'package:v1_micro_finance/screens/nominee/nominee_save_screen.dart';
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
    _loadNominees();
  }

  void _loadNominees() {
    final auth = Provider.of<AuthViewModel>(context, listen: false);
    final nomineeVM = Provider.of<NomineeViewModel>(context, listen: false);

    if (auth.user != null) {
      nomineeVM.fetchNominees(auth.user!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);
    final nomineeVM = Provider.of<NomineeViewModel>(context);

    return Scaffold(
      appBar: CommonAppBar(title: "Nominee"),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const NomineeSaveScreen())),
        child: const Icon(Icons.add),
      ),
      body: _buildBody(auth, nomineeVM),
    );
  }

  Widget _buildBody(AuthViewModel auth, NomineeViewModel vm) {
    if (auth.user == null) return const Center(child: Text('Please login'));

    if (vm.isLoading) return const Center(child: CircularProgressIndicator());

    if (vm.errorMessage != null) return Center(child: Text(vm.errorMessage!));

    if (vm.nominees.isEmpty)
      return const Center(child: Text('No nominees found'));

    return ListView.builder(
      itemCount: vm.nominees.length,
      itemBuilder: (context, index) => Card(
        elevation: 4,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${vm.nominees[index].name}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text('Relationship: ${vm.nominees[index].relationship}',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 4),
              Text('Cell: ${vm.nominees[index].cellNo}',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 4),
              Text('Email: ${vm.nominees[index].email}',
                  style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
