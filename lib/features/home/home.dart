import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/blocs/theme_bloc/theme_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Hello World"),
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return IconButton(
                    onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                    icon: state == ThemeState.light
                        ? const Icon(Icons.dark_mode)
                        : const Icon(Icons.light_mode));
              },
            )
          ],
        ),
      ),
    );
  }
}
