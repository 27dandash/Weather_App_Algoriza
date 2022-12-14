import 'package:flutter/material.dart';
import 'package:weather_app_algoriza/constants/screens.dart' as screens;
import 'package:weather_app_algoriza/data/source/local/my_shared_preferences.dart';
import 'package:weather_app_algoriza/data/source/local/my_shared_preferences_keys.dart';
import 'package:weather_app_algoriza/presentation/screens/home/home_screen.dart';
import 'package:weather_app_algoriza/presentation/screens/pick_location_screen/pick_location_screen.dart';
import 'package:weather_app_algoriza/presentation/screens/splash/splash_screen.dart';

class AppRouter {
  late Widget startScreen;

  Route? onGenerateRoute(RouteSettings settings) {
    startScreen = const SplashScreen();

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => startScreen);
      case screens.HOME_SCREEN:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case screens.PICK_LOCATION_SCREEN:
        return MaterialPageRoute(builder: (_) => PickLocationScreen());
      default:
        return null;
    }
  }
}
