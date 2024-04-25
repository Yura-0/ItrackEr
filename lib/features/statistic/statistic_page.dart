import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/blocs/theme_bloc/theme_cubit.dart';
import 'week_month_switch.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  bool _isIncome = true;
  bool _isWeek = true;
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
              setState(() {
                _isIncome = !_isIncome;
              });
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
                    },
                  );
                },
              ),
            ],
          )),
        );
      },
    );
  }
}
