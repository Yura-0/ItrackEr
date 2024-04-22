import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:itracker/l10n/app_loc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/blocs/theme_bloc/theme_cubit.dart';
import '../../../core/blocs/transactions_bloc/transactions_cubit.dart';
import '../add_elem_widget.dart';

class ListTransactionsPage extends StatelessWidget {
  final int category;
  final bool isIncome;
  final String categoryName;
  const ListTransactionsPage(
      {super.key,
      required this.category,
      required this.isIncome,
      required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final tranBloc = context.read<TransactionCubit>();
    List<TransactionModel> categoryTransactions = [];
    if (tranBloc.state.isNotEmpty) {
      categoryTransactions = tranBloc.state
          .where((transaction) => transaction.categoryId == category)
          .toList();
      categoryTransactions.sort((a, b) => b.date.compareTo(a.date));
    }

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Padding(
                padding: EdgeInsets.only(right: Adaptive.w(10)),
                child: Text(
                  categoryName,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            backgroundColor: isIncome
                ? state == ThemeState.light
                    ? const Color.fromARGB(255, 0, 183, 255)
                    : const Color.fromARGB(255, 0, 42, 255)
                : state == ThemeState.light
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
                ? state == ThemeState.light
                    ? const Color.fromARGB(255, 0, 183, 255)
                    : const Color.fromARGB(255, 0, 42, 255)
                : state == ThemeState.light
                    ? const Color.fromARGB(255, 255, 0, 0)
                    : const Color.fromARGB(255, 185, 6, 6),
            child: const Icon(Icons.add),
          ),
          body: categoryTransactions.isEmpty
              ? Center(
                  child: Text(
                    context.loc.there_are_no_entries,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 25),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                transaction.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                '${isIncome ? "" : "-"}${transaction.amount}',
                                style: TextStyle(
                                    color: isIncome
                                        ? state == ThemeState.light
                                            ? const Color.fromARGB(
                                                255, 0, 183, 255)
                                            : const Color.fromARGB(
                                                255, 0, 42, 255)
                                        : state == ThemeState.light
                                            ? const Color.fromARGB(
                                                255, 255, 0, 0)
                                            : const Color.fromARGB(
                                                255, 185, 6, 6),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
