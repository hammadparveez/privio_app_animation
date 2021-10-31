import 'package:flutter/material.dart';
import 'package:privio/src/config/routes.dart';
import 'package:privio/src/shared/constants.dart';
import 'package:privio/src/shared/strings.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      navigatorKey: navigatorKey,
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: Routes.home,
      theme: ThemeData(
        scaffoldBackgroundColor: kThemeColor,
        appBarTheme: const AppBarTheme(elevation: 0, color: kThemeColor),
        hintColor: kLightThemeColor,
        disabledColor: kDisabledColor,
        inputDecorationTheme: const InputDecorationTheme(
          border: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: kLightThemeColor)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: kLightThemeColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: kLightThemeColor)),
        ),
        textTheme: const TextTheme(
            subtitle1: TextStyle(color: kWhiteColor),
            bodyText1: TextStyle(
                color: kLightThemeColor,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.1),
            headline2: TextStyle(
                color: kWhiteColor,
                height: 1.5,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: kLightThemeColor),
        colorScheme: const ColorScheme.light(
          //onSecondary: kLightThemeColor,
          //onPrimary: kLightThemeColor,
          //primaryVariant: kLightThemeColor,
          //surface: kLightThemeColor,
          //secondaryVariant: kLightThemeColor,
          primary: kLightThemeColor,
          secondary: kLightThemeColor,
          onSurface: kLightThemeColor,
        ),
      ),
    );
  }
}
