import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itracker/l10n/app_loc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/blocs/theme_bloc/theme_cubit.dart';
import 'circle_widget.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

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
                  context.loc.dont_forget_expenses,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleWidget(
                      name: context.loc.payments,
                      color: state == ThemeState.light
                          ? const Color.fromARGB(255, 255, 0, 0)
                          : const Color.fromARGB(255, 185, 6, 6),
                      icon: Icon(
                        Icons.payment,
                        color: Colors.white,
                        size: Adaptive.h(5),
                      ),
                      width: Adaptive.h(13),
                      height: Adaptive.h(13),
                      onTap: () => {},
                    ),
                    CircleWidget(
                      name: context.loc.shopping,
                      color: state == ThemeState.light
                          ? const Color.fromARGB(255, 255, 0, 0)
                           : const Color.fromARGB(255, 185, 6, 6),
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: Adaptive.h(5),
                      ),
                      width: Adaptive.h(13),
                      height: Adaptive.h(13),
                      onTap: () => {},
                    ),
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleWidget(
                      name: context.loc.medicine,
                      color: state == ThemeState.light
                          ? const Color.fromARGB(255, 255, 0, 0)
                          : const Color.fromARGB(255, 185, 6, 6),
                      icon: Icon(
                        Icons.medical_services,
                        color: Colors.white,
                        size: Adaptive.h(5),
                      ),
                      width: Adaptive.h(13),
                      height: Adaptive.h(13),
                      onTap: () => {},
                    ),
                    CircleWidget(
                      name: context.loc.entertainment,
                      color: state == ThemeState.light
                          ? const Color.fromARGB(255, 255, 0, 0)
                          : const Color.fromARGB(255, 185, 6, 6),
                      icon: Icon(
                        Icons.videogame_asset,
                        color: Colors.white,
                        size: Adaptive.h(5),
                      ),
                      width: Adaptive.h(13),
                      height: Adaptive.h(13),
                      onTap: () => {},
                    ),
                  ],
                ),
                 SizedBox(
                  height: Adaptive.h(5),
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleWidget(
                      name: context.loc.jorney,
                      color: state == ThemeState.light
                          ? const Color.fromARGB(255, 255, 0, 0)
                          : const Color.fromARGB(255, 185, 6, 6),
                      icon: Icon(
                        Icons.commute,
                        color: Colors.white,
                        size: Adaptive.h(5),
                      ),
                      width: Adaptive.h(13),
                      height: Adaptive.h(13),
                      onTap: () => {},
                    ),
                    CircleWidget(
                      name: context.loc.auto,
                      color: state == ThemeState.light
                          ? const Color.fromARGB(255, 255, 0, 0)
                          : const Color.fromARGB(255, 185, 6, 6),
                      icon: Icon(
                        Icons.directions_car,
                        color: Colors.white,
                        size: Adaptive.h(5),
                      ),
                      width: Adaptive.h(13),
                      height: Adaptive.h(13),
                      onTap: () => {},
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