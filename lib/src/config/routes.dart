import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:privio/src/screens/form_screen/form_screen.dart';
import 'package:privio/src/screens/home/home.dart';
import 'package:privio/src/screens/movies/movies_list_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const home = '/home';
  static const login = '/login';
  static const signup = '/signup';
  static const formView = '/form';
  static const movie = '/movie';
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case formView:
        return MaterialPageRoute(builder: (_) => FormScreen());
      case movie:
        return MaterialPageRoute(builder: (_) => const MovieListScreen());
    }
  }
}
