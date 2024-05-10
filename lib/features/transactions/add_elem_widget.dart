// Шаблон додавання транзакції
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:itracker/l10n/app_loc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/blocs/transactions_bloc/transactions_cubit.dart';

class AddElem extends StatefulWidget {
  final int categoryId;
  final bool isIncome;

  const AddElem({super.key, required this.categoryId, required this.isIncome});

  @override
  _AddElemState createState() => _AddElemState();
}

class _AddElemState extends State<AddElem> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late TextEditingController _dateController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _amountController = TextEditingController();
    _dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
    _descriptionController = TextEditingController();
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
    final tranBloc = context.read<TransactionCubit>();
    return AlertDialog(
      title: Center(child: Text(context.loc.add_element)),
      content: SizedBox(
        width: Adaptive.w(80),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  maxLength: 15,
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
                  maxLength: 10,
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
                  readOnly: true,
                  decoration: InputDecoration(labelText: context.loc.date),
                  onTap: () async {
                    final DateTime now = DateTime.now();
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: DateTime(2015, 8),
                      lastDate: now,
                    );
                    if (picked != null) {
                      setState(() {
                        _dateController.text =
                            DateFormat('yyyy-MM-dd').format(picked);
                      });
                    }
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration:
                      InputDecoration(labelText: context.loc.description),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(context.loc.cancel),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  tranBloc.addTransaction(
                    TransactionModel(
                      id: 0,
                      name: _nameController.text,
                      amount: double.parse(_amountController.text),
                      date:
                          DateFormat('yyyy-MM-dd').parse(_dateController.text),
                      description: _descriptionController.text,
                      categoryId: widget.categoryId,
                      isIncome: widget.isIncome,
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text(context.loc.save),
            ),
          ],
        ),
      ],
    );
  }
}
