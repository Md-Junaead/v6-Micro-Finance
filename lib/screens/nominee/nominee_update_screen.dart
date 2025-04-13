import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/widgets/comon_appbar.dart';
import 'package:v1_micro_finance/screens/nominee/nominee_viewmodel.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';

class UpdateNomineeScreen extends StatefulWidget {
  const UpdateNomineeScreen({super.key});

  @override
  State<UpdateNomineeScreen> createState() => _UpdateNomineeScreenState();
}

class _UpdateNomineeScreenState extends State<UpdateNomineeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _relationController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    final nomineeVM = context.read<NomineeViewModel>();

    // Pre-fill form with existing nominee data
    if (nomineeVM.nominees.isNotEmpty) {
      final nominee = nomineeVM.nominees.first;
      _nameController = TextEditingController(text: nominee.name);
      _emailController = TextEditingController(text: nominee.email);
      _phoneController = TextEditingController(text: nominee.cellNo);
      _relationController = TextEditingController(text: nominee.relationship);
      _selectedDate = nominee.dob;
    } else {
      _nameController = TextEditingController();
      _emailController = TextEditingController();
      _phoneController = TextEditingController();
      _relationController = TextEditingController();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _relationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nomineeVM = context.watch<NomineeViewModel>();
    final authVM = context.read<AuthViewModel>();

    return Scaffold(
      appBar: const CommonAppBar(title: "Update Nominee"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
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
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (v) =>
                        !v!.contains('@') ? 'Invalid email' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration:
                        const InputDecoration(labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                    validator: (v) => v!.isEmpty ? 'Required field' : null,
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration:
                          const InputDecoration(labelText: 'Date of Birth'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'Select Date'
                                : DateFormat('dd/MM/yyyy')
                                    .format(_selectedDate!),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _relationController,
                    decoration:
                        const InputDecoration(labelText: 'Relationship'),
                    validator: (v) => v!.isEmpty ? 'Required field' : null,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF06426D),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: nomineeVM.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate() &&
                                _selectedDate != null) {
                              if (nomineeVM.nominees.isEmpty) return;

                              final success = await nomineeVM.updateNominee(
                                nomineeId: nomineeVM.nominees.first.id,
                                name: _nameController.text,
                                email: _emailController.text,
                                cellNo: _phoneController.text,
                                dob: _selectedDate!,
                                relationship: _relationController.text,
                              );

                              if (success && context.mounted) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Nominee updated successfully')),
                                );
                              }
                            }
                          },
                    child: nomineeVM.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'UPDATE NOMINEE',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
