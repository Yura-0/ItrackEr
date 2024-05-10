// Модуль маршрутизації
import 'package:flutter/material.dart';

import '../../features/home/home.dart';
import '../../features/loading/load_page.dart';

class AppRoutes {
  static const String init = '/';
  static const String home = '/home';

  static Map<String, WidgetBuilder> getRoutes() {
    return { 
         init: (context) => const LoadPage(),
         home: (context) => const HomePage(),
    };
  }
}

