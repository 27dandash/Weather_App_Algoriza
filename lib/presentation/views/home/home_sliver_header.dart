import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app_algoriza/constants/constant_methods.dart';
import 'package:weather_app_algoriza/data/models/responses/weather_response/weather_response.dart';
import 'package:weather_app_algoriza/presentation/widgets/default_cached_network_image.dart';
import 'package:weather_app_algoriza/presentation/widgets/default_icon_button.dart';
import 'package:weather_app_algoriza/presentation/widgets/default_text.dart';

import '../../../constants/components/components.dart';
import '../../../constants/constants.dart';
import '../../screens/search_with_lat/search_with_lat.dart';
import '../../styles/colors.dart';

class HomeSliverHeader extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;
  @override
  final double maxExtent;
  final WeatherResponse weatherResponse;

  const HomeSliverHeader({
    Key? key,
    required this.minExtent,
    required this.maxExtent,
    required this.weatherResponse,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Scaffold(
      body: Container(
        color: defaultAppColor2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultIconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  size: 30.sp,
                )),
            Row(
              children: [
                DefaultText(
                  text:
                      '${changeTempUnit(weatherResponse.currentWeather.tempC, weatherResponse.currentWeather.tempF)}°',
                  fontSize: 50.sp,
                ),
                const Spacer(),
                DefaultCachedNetworkImage(
                  imageUrl:
                      httpSC + weatherResponse.currentWeather.condition.icon,
                  fit: BoxFit.fill,
                  height: 15.h,
                )
              ],
            ),
            Row(
              children: [
                DefaultText(
                  text: weatherResponse.location.name,
                  fontSize: 25.sp,
                ),
                DefaultIconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_pin,
                      size: 20.sp,
                    )),
              ],
            ),
            const Spacer(),
            DefaultText(
              text:
                  '${changeTempUnit(weatherResponse.forecast.forecastday[0].day.maxtempC, weatherResponse.forecast.forecastday[0].day.maxtempF)}° / ${changeTempUnit(weatherResponse.forecast.forecastday[0].day.mintempC, weatherResponse.forecast.forecastday[0].day.mintempF)}° Feels Like ${changeTempUnit(weatherResponse.currentWeather.feelslikeC, weatherResponse.currentWeather.feelslikeF)}°',
              fontSize: 12.sp,
            ),
            // Positioned(
            //   left: 16.0,
            //   right: 16.0,
            //   bottom: 16.0,
            //   child: Text(
            //     'Lorem ipsum',
            //     style: TextStyle(
            //       fontSize: 32.0,
            //       color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  double titleOpacity(double shrinkOffset) {
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
