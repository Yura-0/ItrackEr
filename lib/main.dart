import 'package:flutter/material.dart';

import 'app.dart';
import 'core/app/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const TracerApp());
}
