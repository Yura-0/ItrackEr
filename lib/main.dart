// Додаток "Itrecker" для контролю особистих рахунків
// Розробник: Кривоносов Ю.A.
// Точка входу у програму
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/app/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // підключення DI
  await setupLocator();
  // запуск програми
  runApp(const TracerApp());
}
