import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itracker/core/app/injector.dart';
import 'package:itracker/features/transactions/pages/income_page.dart';

import '../../core/blocs/theme_bloc/theme_cubit.dart';
import '../transactions/pages/expense_page.dart';
import 'botom_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  locator<ThemeCubit>().toggleTheme();
                },
                icon: state == ThemeState.light
                    ? const Icon(Icons.dark_mode)
                    : const Icon(Icons.light_mode),
              );
            },
          )
        ],
      ),
      body: PageView(
        controller: pageController,
        children: const [
          IncomePage(),
          ExpensePage(),
          Center(child: Text('Expense Page')),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        pageController: pageController,
      ),
    );
  }
}
