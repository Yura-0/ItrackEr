// Екран транзакції
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:itracker/l10n/app_loc.dart';
import '../../../core/blocs/theme_bloc/theme_cubit.dart';
import '../../../core/blocs/transactions_bloc/transactions_cubit.dart';

class ElemPage extends StatefulWidget {
  final TransactionModel trans;

  const ElemPage({Key? key, required this.trans}) : super(key: key);

  @override
  _ElemPageState createState() => _ElemPageState();
}

class _ElemPageState extends State<ElemPage> {
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late TextEditingController _dateController;
  late TextEditingController _descriptionController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.trans.name);
    _amountController =
        TextEditingController(text: widget.trans.amount.toString());
    _dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(widget.trans.date));
    _descriptionController =
        TextEditingController(text: widget.trans.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themebloc = context.read<ThemeCubit>();
    final transbloc = context.read<TransactionCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.trans.isIncome
            ? themebloc.state == ThemeState.light
                ? const Color.fromARGB(255, 0, 183, 255)
                : const Color.fromARGB(255, 0, 42, 255)
            : themebloc.state == ThemeState.light
                ? const Color.fromARGB(255, 255, 0, 0)
                : const Color.fromARGB(255, 185, 6, 6),
        title: Center(
          child: Text(context.loc.transaction_details,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ),
        actions: [
          IconButton(
            icon: _isEditing ? const Icon(Icons.close) : const Icon(Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              enabled: _isEditing,
              decoration: InputDecoration(labelText: context.loc.name),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.loc.enter_name;
                }
                return null;
              },
            ),
            TextFormField(
              controller: _amountController,
              enabled: _isEditing,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d+[\.]?\d{0,2}'),
                ),
              ],
              decoration: InputDecoration(labelText: context.loc.amount),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.loc.enter_amount;
                }
                return null;
              },
            ),
            TextFormField(
              controller: _dateController,
              enabled: _isEditing,
              readOnly: true,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: widget.trans.date,
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101),
                );
                if (picked != null) {
                  setState(() {
                    _dateController.text =
                        DateFormat('yyyy-MM-dd').format(picked);
                  });
                }
              },
              decoration: InputDecoration(labelText: context.loc.date),
            ),
            TextFormField(
              controller: _descriptionController,
              enabled: _isEditing,
              decoration: InputDecoration(labelText: context.loc.description),
            ),
          ],
        ),
      ),
      floatingActionButton: _isEditing
          ? FloatingActionButton(
              backgroundColor: widget.trans.isIncome
                  ? themebloc.state == ThemeState.light
                      ? const Color.fromARGB(255, 0, 183, 255)
                      : const Color.fromARGB(255, 0, 42, 255)
                  : themebloc.state == ThemeState.light
                      ? const Color.fromARGB(255, 255, 0, 0)
                      : const Color.fromARGB(255, 185, 6, 6),
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _amountController.text.isNotEmpty) {
                  transbloc.updateTransaction(widget.trans.copyWith(
                    name: _nameController.text,
                    amount: double.parse(_amountController.text),
                    date: DateFormat('yyyy-MM-dd').parse(_dateController.text),
                    description: _descriptionController.text,
                  ));
                  setState(() {
                    _isEditing = false;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(context.loc.field_is_required),
                  ));
                }
              },
              child: const Icon(Icons.check, color: Colors.white),
            )
          : null,
    );
  }
}


