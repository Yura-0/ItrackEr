import 'package:get_it/get_it.dart';
import 'package:itracker/db.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/theme_bloc/theme_cubit.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => prefs);

  final database = AppDatabase();
  locator.registerLazySingleton<AppDatabase>(() => database);

  locator.registerLazySingleton<ThemeCubit>(() => ThemeCubit(prefs));
}
