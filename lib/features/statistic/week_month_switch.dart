// Віджет перемикання місяців та тижнів
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itracker/l10n/app_loc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/blocs/theme_bloc/theme_cubit.dart';

class WeekMonthSwitcher extends StatefulWidget {
  final bool isIncome;
  final bool isWeek;
  final ValueChanged<bool> onChanged;

  const WeekMonthSwitcher({
    Key? key,
    required this.isWeek,
    required this.onChanged,
    required this.isIncome,
  }) : super(key: key);

  @override
  _WeekMonthSwitcherState createState() => _WeekMonthSwitcherState();
}

class _WeekMonthSwitcherState extends State<WeekMonthSwitcher> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            widget.onChanged(!widget.isWeek);
          },
          child: Container(
            height: Adaptive.h(5),
            width: Adaptive.w(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: state == ThemeState.light
                  ? const Color.fromARGB(255, 233, 228, 228)
                  : const Color.fromARGB(255, 36, 35, 35),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  left: widget.isWeek ? 0 : Adaptive.w(25),
                  child: Container(
                    width: Adaptive.w(25),
                    height: Adaptive.h(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.isIncome
                          ? state == ThemeState.light
                              ? const Color.fromARGB(255, 0, 183, 255)
                              : const Color.fromARGB(255, 0, 42, 255)
                          : state == ThemeState.light
                              ? const Color.fromARGB(255, 255, 0, 0)
                              : const Color.fromARGB(255, 185, 6, 6),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Center(
                        child: Text(
                          context.loc.week,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Adaptive.w(15),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Center(
                        child: Text(
                          context.loc.month,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
