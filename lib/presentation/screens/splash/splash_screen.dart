import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app_algoriza/business_logic/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app_algoriza/constants/screens.dart' as screens;

import '../../../data/source/local/my_shared_preferences.dart';
import '../../../data/source/local/my_shared_preferences_keys.dart';
import '../../styles/colors.dart';
import '../../widgets/default_rich_text.dart';
import '../../widgets/default_text_span.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    Timer(const Duration(milliseconds: 3000), () async {
      if (MySharedPreferences.getBoolean(key: MySharedKeys.firstTimeLocation) ==
          true) {
        await WeatherCubit.get(context)
            .getWeatherResponse(MySharedPreferences.getString(
                key: MySharedKeys.currentWeatherLocation))
            .then((value) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(screens.HOME_SCREEN, (route) => false);
        });
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            screens.PICK_LOCATION_SCREEN, (route) => false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultAppColor2,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FadeTransition(
                  opacity: _animation,
                  child:  Image.asset(
                    'assets/image/sun.gif',
                    height: 200,
                    width: 200,
                  ),),
            ),
            SizedBox(height: 30,),
            Flexible(
                child: Text('Weather App',style: TextStyle(color: Colors.white70,fontSize: 30),)),
          ],
        ),
      ),
    );
  }
}
