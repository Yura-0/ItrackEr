import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:itracker/core/app/injector.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/app/routes.dart';
import 'core/blocs/theme_bloc/theme_cubit.dart';

class TracerApp extends StatelessWidget {
  const TracerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => locator<ThemeCubit>()..loadTheme(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return MaterialApp(
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              initialRoute: AppRoutes.init,
              theme: state == ThemeState.light ? lightTheme : darkTheme,
              routes: AppRoutes.getRoutes(),
            );
          },
        ),
      );
    });
  }
}

