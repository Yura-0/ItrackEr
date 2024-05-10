// Модуль DI
import 'package:get_it/get_it.dart';
import 'package:itracker/db.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/theme_bloc/theme_cubit.dart';
import '../blocs/transactions_bloc/transactions_cubit.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Реєстрація sharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => prefs);

  // Реєстрація БД
  final database = AppDatabase();
  locator.registerLazySingleton<AppDatabase>(() => database);

  // Реєстрація блоку теми
  locator.registerLazySingleton<ThemeCubit>(() => ThemeCubit(prefs));

  // Реєстрація блоку транзакцій
  locator.registerLazySingleton<TransactionCubit>(
      () => TransactionCubit(database));
}
