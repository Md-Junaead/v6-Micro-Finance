import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/screens/nominee/nominee_viewmodel.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';

class NomineeSaveScreen extends StatefulWidget {
  const NomineeSaveScreen({super.key});

  @override
  State<NomineeSaveScreen> createState() => _NomineeSaveScreenState();
}

class _NomineeSaveScreenState extends State<NomineeSaveScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _relationController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);
    final nomineeVM = Provider.of<NomineeViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Nominee')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (v) => v!.isEmpty ? 'Required field' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) => !v!.contains('@') ? 'Invalid email' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (v) => v!.isEmpty ? 'Required field' : null,
              ),
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) setState(() => _selectedDate = date);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                  child: Text(_selectedDate == null
                      ? 'Select Date'
                      : DateFormat('dd/MM/yyyy').format(_selectedDate!)),
                ),
              ),
              TextFormField(
                controller: _relationController,
                decoration: const InputDecoration(labelText: 'Relationship'),
                validator: (v) => v!.isEmpty ? 'Required field' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      _selectedDate != null) {
                    final success = await nomineeVM.saveNominee(
                      name: _nameController.text,
                      email: _emailController.text,
                      cellNo: _phoneController.text,
                      dob: _selectedDate!,
                      relationship: _relationController.text,
                      userId: auth.user!.id,
                    );

                    if (success) Navigator.pop(context);
                  }
                },
                child: const Text('Save Nominee'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
