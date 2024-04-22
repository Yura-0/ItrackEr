import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itracker/features/transactions/circle_widget.dart';
import 'package:itracker/l10n/app_loc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/blocs/theme_bloc/theme_cubit.dart';
import 'list_transactions_page.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  context.loc.add_new_income,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(5),
                ),
                CircleWidget(
                  name: context.loc.bank_storage,
                  color: state == ThemeState.light
                      ? const Color.fromARGB(255, 0, 183, 255)
                      : const Color.fromARGB(255, 0, 42, 255),
                  icon: Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: Adaptive.h(5),
                  ),
                  width: Adaptive.h(13),
                  height: Adaptive.h(13),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListTransactionsPage(
                          category: 1,
                          isIncome: true,
                          categoryName: context.loc.bank_storage,
                        ),
                      ),
                    ),
                  },
                ),
                SizedBox(
                  height: Adaptive.h(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleWidget(
                      name: context.loc.cash_storage,
                      color: state == ThemeState.light
                          ? const Color.fromARGB(255, 0, 183, 255)
                          : const Color.fromARGB(255, 0, 42, 255),
                      icon: Icon(
                        Icons.attach_money,
                        color: Colors.white,
                        size: Adaptive.h(6),
                      ),
                      width: Adaptive.h(13),
                      height: Adaptive.h(13),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListTransactionsPage(
                              category: 2,
                              isIncome: true,
                              categoryName: context.loc.cash_storage,
                            ),
                          ),
                        ),
                      },
                    ),
                    CircleWidget(
                      name: context.loc.passive_income,
                      color: state == ThemeState.light
                          ? const Color.fromARGB(255, 0, 183, 255)
                          : const Color.fromARGB(255, 0, 42, 255),
                      icon: Icon(
                        Icons.trending_up,
                        color: Colors.white,
                        size: Adaptive.h(6),
                      ),
                      width: Adaptive.h(13),
                      height: Adaptive.h(13),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListTransactionsPage(
                              category: 3,
                              isIncome: true,
                              categoryName: context.loc.passive_income,
                            ),
                          ),
                        ),
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
