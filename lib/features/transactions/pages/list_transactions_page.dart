import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:itracker/l10n/app_loc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/blocs/theme_bloc/theme_cubit.dart';
import '../../../core/blocs/transactions_bloc/transactions_cubit.dart';
import '../add_elem_widget.dart';

class ListTransactionsPage extends StatelessWidget {
  final int category;
  final bool isIncome;
  final String categoryName;

  const ListTransactionsPage({
    Key? key,
    required this.category,
    required this.isIncome,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themebloc = context.read<ThemeCubit>();
    List<TransactionModel> categoryTransactions = context
        .read<TransactionCubit>()
        .state
        .where((transaction) => transaction.categoryId == category)
        .toList();
    categoryTransactions.sort((a, b) => b.date.compareTo(a.date));
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return BlocBuilder<TransactionCubit, List<TransactionModel>>(
          builder: (context, state) {
            return BlocListener<TransactionCubit, List<TransactionModel>>(
              listener: (context, state) {
                categoryTransactions = state
                    .where((transaction) => transaction.categoryId == category)
                    .toList();
                categoryTransactions.sort((a, b) => b.date.compareTo(a.date));
              },
              child: Scaffold(
                appBar: AppBar(
                  title: Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: Adaptive.w(10)),
                      child: Text(
                        categoryName,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  backgroundColor: isIncome
                      ? themebloc.state == ThemeState.light
                          ? const Color.fromARGB(255, 0, 183, 255)
                          : const Color.fromARGB(255, 0, 42, 255)
                      : themebloc.state == ThemeState.light
                          ? const Color.fromARGB(255, 255, 0, 0)
                          : const Color.fromARGB(255, 185, 6, 6),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddElem(
                        isIncome: isIncome,
                        categoryId: category,
                      ),
                    );
                  },
                  backgroundColor: isIncome
                      ? themebloc.state == ThemeState.light
                          ? const Color.fromARGB(255, 0, 183, 255)
                          : const Color.fromARGB(255, 0, 42, 255)
                      : themebloc.state == ThemeState.light
                          ? const Color.fromARGB(255, 255, 0, 0)
                          : const Color.fromARGB(255, 185, 6, 6),
                  child: const Icon(Icons.add),
                ),
                body: categoryTransactions.isEmpty
                    ? Center(
                        child: Text(
                          context.loc.there_are_no_entries,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: categoryTransactions.length,
                        itemBuilder: (context, index) {
                          final transaction = categoryTransactions[index];
                          return ListTile(
                            onTap: () {},
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      transaction.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${isIncome ? "" : "-"}${transaction.amount}',
                                      style: TextStyle(
                                        color: isIncome
                                            ? themebloc.state ==
                                                    ThemeState.light
                                                ? const Color.fromARGB(
                                                    255, 0, 183, 255)
                                                : const Color.fromARGB(
                                                    255, 0, 42, 255)
                                            : themebloc.state ==
                                                    ThemeState.light
                                                ? const Color.fromARGB(
                                                    255, 255, 0, 0)
                                                : const Color.fromARGB(
                                                    255, 185, 6, 6),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(DateFormat('yyyy-MM-dd').format(
                                  transaction.date,
                                )),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
