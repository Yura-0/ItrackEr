// Екран статистики
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itracker/l10n/app_loc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/blocs/theme_bloc/theme_cubit.dart';
import '../../core/blocs/transactions_bloc/transactions_cubit.dart';
import 'chart_widget.dart';
import 'week_month_switch.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  bool _isIncome = true;
  bool _isMonth = true;
  late List<TransactionModel> _trans = [];

  @override
  void initState() {
    super.initState();
    _trans = context.read<TransactionCubit>().state;
    _trans = sortByDate(_trans, _isMonth);
    _trans = sortByCategory(_trans, _isIncome);
  }

  // Метод сортування транзакцій по категоріям
  List<TransactionModel> sortByCategory(
      List<TransactionModel> transactions, bool isIncome) {
    List<int> allowedCategories = isIncome ? [1, 2, 3] : [4, 5, 6, 7, 8, 9];

    return transactions
        .where(
            (transaction) => allowedCategories.contains(transaction.categoryId))
        .toList();
  }

  // Метод сортування транзакцій по даті
  List<TransactionModel> sortByDate(
      List<TransactionModel> transactions, bool isMonth) {
    DateTime now = DateTime.now();
    DateTime start;
    DateTime end;

    if (isMonth) {
      start = DateTime(now.year, now.month, 1);
      end = DateTime(now.year, now.month + 1, 0);
    } else {
      start = DateTime(now.year, 1, 1);
      end = DateTime(now.year, 12, 31);
    }

    return transactions
        .where((transaction) =>
            transaction.date.isAfter(start) && transaction.date.isBefore(end))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: _isIncome
                ? state == ThemeState.light
                    ? const Color.fromARGB(255, 0, 183, 255)
                    : const Color.fromARGB(255, 0, 42, 255)
                : state == ThemeState.light
                    ? const Color.fromARGB(255, 255, 0, 0)
                    : const Color.fromARGB(255, 185, 6, 6),
            onPressed: () {
              setState(
                () {
                  _isIncome = !_isIncome;
                  _trans = context.read<TransactionCubit>().state;
                  _trans = sortByCategory(_trans, _isIncome);
                  _trans = sortByDate(_trans, _isMonth);
                },
              );
            },
            child: _isIncome
                ? const Icon(
                    Icons.wallet,
                  )
                : const Icon(
                    Icons.attach_money,
                  ),
          ),
          body: Center(
              child: Column(
            children: [
              SizedBox(
                height: Adaptive.h(5),
              ),
              WeekMonthSwitcher(
                isIncome: _isIncome,
                isMonth: _isMonth,
                onChanged: (value) {
                  setState(
                    () {
                      _isMonth = value;
                      _trans = context.read<TransactionCubit>().state;
                      _trans = sortByCategory(_trans, _isIncome);
                      _trans = sortByDate(_trans, _isMonth);
                    },
                  );
                },
              ),
              SizedBox(
                height: Adaptive.h(10),
              ),
              _trans.isEmpty
                  ? Text(
                      context.loc.no_data,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : MyPieChart(
                      transactions: _trans,
                    ),
            ],
          )),
        );
      },
    );
  }
}
