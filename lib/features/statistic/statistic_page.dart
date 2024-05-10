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
  bool _isWeek = true;
  late List<TransactionModel> _trans = [];

  @override
  void initState() {
    super.initState();
    _trans = context.read<TransactionCubit>().state;
    _trans = sortByDate(_trans, _isWeek);
    _trans = sortByCategory(_trans, _isIncome);
  }

  List<TransactionModel> sortByCategory(
      List<TransactionModel> transactions, bool isIncome) {
    List<int> allowedCategories = isIncome ? [1, 2, 3] : [4, 5, 6, 7, 8, 9];

    return transactions
        .where(
            (transaction) => allowedCategories.contains(transaction.categoryId))
        .toList();
  }

  List<TransactionModel> sortByDate(
      List<TransactionModel> transactions, bool isWeek) {
    DateTime now = DateTime.now();
    DateTime start;
    DateTime end;

    if (isWeek) {
      start = DateTime(now.year, now.month, now.day - now.weekday);
      end = DateTime(now.year, now.month, now.day + (7 - now.weekday));
    } else {
      start = DateTime(now.year, now.month, 1);
      end = DateTime(now.year, now.month + 1, 0);
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
                  _trans = sortByDate(_trans, _isWeek);
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
                isWeek: _isWeek,
                onChanged: (value) {
                  setState(
                    () {
                      _isWeek = value;
                      _trans = context.read<TransactionCubit>().state;
                      _trans = sortByCategory(_trans, _isIncome);
                      _trans = sortByDate(_trans, _isWeek);
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
