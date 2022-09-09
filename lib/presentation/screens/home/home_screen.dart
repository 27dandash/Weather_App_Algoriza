import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app_algoriza/business_logic/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app_algoriza/data/models/responses/weather_response/weather_response.dart';
import 'package:weather_app_algoriza/presentation/styles/colors.dart';
import 'package:weather_app_algoriza/presentation/views/home/hours_temp_item.dart';
import 'package:weather_app_algoriza/presentation/widgets/default_text.dart';

import '../../../constants/components/components.dart';
import '../../../constants/constant_methods.dart';
import '../../../constants/constants.dart';
import '../../../data/models/responses/forecast_response/forecast_response.dart';
import '../../widgets/default_cached_network_image.dart';
import '../../widgets/default_icon_button.dart';
import '../search_with_lat/search_with_lat.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherCubit weatherCubit;
  late Color backgroundColor;

  @override
  void initState() {
    backgroundColor = defaultAppColor2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    weatherCubit = WeatherCubit.get(context);
    WeatherResponse weatherResponse = weatherCubit.weatherResponse;
    final List<ChartData> chartData = List.generate(
      weatherResponse.forecast.forecastday[0].hour.length,
          (index) =>
          ChartData(index, weatherResponse.forecast.forecastday[0].hour[index]),
    );
    return BlocBuilder<WeatherCubit, WeatherStates>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            drawer: Drawer(
              backgroundColor: defaultAppColor2,
              child: Scaffold(
                backgroundColor: defaultAppColor2,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  actions: [
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          //dddddd
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: defaultAppColor2,
                        ))
                  ],
                ),
                body: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 200,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Center(
                          child: Text(
                            'Weather App',
                            style: TextStyle(fontSize: 25),
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: TextButton(
                          onPressed: () {
                            navigateTo(context, const SearchWithlat());
                          },
                          child: const Text(' Search With Lat And Long',
                              style: TextStyle(fontSize: 20))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Icon(Icons.star),
                            Spacer(),
                            TextButton(
                                onPressed: () {},
                                child: const Text('Favourite Location',
                                    style: TextStyle(fontSize: 20))),
                            Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: CircleAvatar(
                                    child: Icon(Icons.question_mark)))
                          ],
                        )),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              backgroundColor: defaultAppColor2,
              elevation: 0,
            ),
            backgroundColor: backgroundColor,
            body: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is UserScrollNotification) {
                    if (notification.direction == ScrollDirection.forward) {
                      printTest('down');
                      // setState(() {
                      //   backgroundColor.withOpacity(1);
                      // });
                    } else if (notification.direction ==
                        ScrollDirection.reverse) {
                      printTest('up');
                      // setState(() {
                      //   backgroundColor.withOpacity(0);
                      // });
                      // Handle scroll up.
                    }
                  }

                  return false;
                },
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                        scrolledUnderElevation: 30.h,
                        backgroundColor: backgroundColor,
                        toolbarHeight: 10.h,
                        expandedHeight: 33.h,
                        collapsedHeight: 30.h,
                        pinned: true,
                        floating: true,
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        flexibleSpace: FlexibleSpaceBar(
                          titlePadding: EdgeInsetsDirectional.only(
                              start: 5.w, end: 2.w, top: 12.h),
                          centerTitle: false,
                          expandedTitleScale: 1.3,
                          background: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  DefaultText(
                                    text:
                                    '${changeTempUnit(
                                        weatherResponse.forecast.forecastday[0]
                                            .day.maxtempC,
                                        weatherResponse.forecast.forecastday[0]
                                            .day.maxtempF)} / ${changeTempUnit(
                                        weatherResponse.forecast.forecastday[0]
                                            .day.mintempC,
                                        weatherResponse.forecast.forecastday[0]
                                            .day
                                            .mintempF)} Feels Like ${changeTempUnit(
                                        weatherResponse.currentWeather
                                            .feelslikeC,
                                        weatherResponse.currentWeather
                                            .feelslikeF)}',
                                    fontSize: 12.sp,
                                  ),
                                  DefaultText(
                                    text:
                                    '${weatherResponse.currentWeather.condition
                                        .text}, ${DateFormat('hh:mm a').format(
                                        DateTime.parse(
                                            weatherResponse.currentWeather
                                                .lastUpdated))}',
                                    fontSize: 12.sp,
                                  ),
                                ]),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  DefaultText(
                                    text:
                                    '${changeTempUnit(
                                        weatherResponse.currentWeather.tempC,
                                        weatherResponse.currentWeather.tempF)}',
                                    fontSize: 30,
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    'assets/image/sun.gif',
                                    height: 90,
                                    width: 90,
                                  ), // Image.asset
                                ],
                              ),
                              Row(
                                children: [
                                  DefaultText(
                                    text: weatherResponse.location.name,
                                    fontSize: 16.sp,
                                  ),
                                  DefaultIconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.location_pin,
                                        size: 15.sp,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        )),
                    SliverToBoxAdapter(
                      child: Container(
                        width: 90.w,
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 3.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                            color: defaultAppWhiteColor.withOpacity(0.5)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: List.generate(
                                    weatherResponse
                                        .forecast.forecastday[0].hour.length,
                                        (index) =>
                                        HoursTempItem(
                                            time:
                                            '${DateFormat('hh:mm a').format(
                                                DateTime.parse(
                                                    weatherResponse.forecast
                                                        .forecastday[0]
                                                        .hour[index].time))}',
                                            temp: changeTempUnit(
                                                weatherResponse
                                                    .forecast
                                                    .forecastday[0]
                                                    .hour[index]
                                                    .tempC,
                                                weatherResponse
                                                    .forecast
                                                    .forecastday[0]
                                                    .hour[index]
                                                    .tempF),
                                            icon: weatherResponse
                                                .forecast
                                                .forecastday[0]
                                                .hour[index]
                                                .condition
                                                .icon,
                                            state: weatherResponse
                                                .forecast
                                                .forecastday[0]
                                                .hour[index]
                                                .condition
                                                .text)),
                              ),
                              SizedBox(
                                width: 580.w,
                                height: 10.h,
                                child: SfCartesianChart(
                                  primaryYAxis: NumericAxis(
                                    isVisible: false,
                                  ),
                                  primaryXAxis: NumericAxis(
                                    isVisible: false,
                                  ),
                                  series: <ChartSeries<ChartData, int>>[
                                    LineSeries<ChartData, int>(
                                        dataSource: chartData,
                                        markerSettings: MarkerSettings(
                                          isVisible: true,
                                        ),
                                        xValueMapper: (ChartData data, _) =>
                                        data.x,
                                        yValueMapper: (ChartData data, _) =>
                                        data.y.tempC),
                                  ],
                                ),
                              ),
                              Row(
                                children: List.generate(
                                    weatherResponse
                                        .forecast.forecastday[0].hour.length,
                                        (index) => HoursTemp(state: "Rain 0%")),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 80,
                        width: 90.w,
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 3.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                            color: defaultAppWhiteColor.withOpacity(0.5)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
//  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 15,),
                                    Center(
                                        child: Text(
                                          'Toda\'s Temperature',
                                          style: TextStyle(fontSize: 17),
                                        )),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
//  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Center(
                                        child: Text(
                                          'Expect the same as yesterdat no Change',
                                          style: TextStyle(fontSize: 13),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        width: 90.w,
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 3.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                            color: defaultAppWhiteColor.withOpacity(0.5)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  children: const [
                                    Text("SATURDAY"),
                                    SizedBox(height: 6,),
                                    Text("SUNDAY"),
                                    SizedBox(height: 6,),
                                    Text("MONDAY"),
                                    SizedBox(height: 6,),
                                    Text("MONDAY"),
                                    SizedBox(height: 6,),
                                    Text("WEDNESDAY"),
                                    SizedBox(height: 6,),
                                    Text("WEDNESDAY"),
                                    SizedBox(height: 6,),
                                    Text("FRIDAY"),
                                  ],
                                ),
                                SizedBox(width: 25,),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.water_drop_outlined),
                                        Text('0%')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.water_drop_outlined),
                                        Text('0%')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.water_drop_outlined),
                                        Text('0%')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.water_drop_outlined),
                                        Text('0%')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.water_drop_outlined),
                                        Text('0%')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.water_drop_outlined),
                                        Text('0%')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.water_drop_outlined),
                                        Text('0%')
                                      ],
                                    ),
                                  ],
                                ),
                                // Column(
                                //   children: [
                                //     DefaultCachedNetworkImage(
                                //       imageUrl:
                                //       httpSC + weatherResponse.currentWeather.condition.icon,
                                //       fit: BoxFit.fill,
                                //       height: 80,
                                //     ),
                                //   ],
                                // ),
SizedBox(width: 29,),
                               // Column(
                               //   children: [
                               //     Row(
                               //       children: [
                               //         DefaultText(
                               //           text:
                               //           '${ weatherResponse.currentWeather.tempC}',
                               //           fontSize: 20,
                               //         ),
                               //         SizedBox(width: 15,),
                               //         DefaultText(
                               //           text:
                               //           '${ weatherResponse.currentWeather.tempF}',
                               //           fontSize: 20,
                               //         ),
                               //       ],
                               //     ),
                               //     Row(
                               //       children: [
                               //         DefaultText(
                               //           text:
                               //           '${ weatherResponse.currentWeather.tempC}',
                               //           fontSize: 20,
                               //         ),
                               //         SizedBox(width: 15,),
                               //         DefaultText(
                               //           text:
                               //           '${ weatherResponse.currentWeather.tempF}',
                               //           fontSize: 20,
                               //         ),
                               //       ],
                               //     ),
                               //     Row(
                               //       children: [
                               //         DefaultText(
                               //           text:
                               //           '${ weatherResponse.currentWeather.tempC}',
                               //           fontSize: 20,
                               //         ),
                               //         SizedBox(width: 15,),
                               //         DefaultText(
                               //           text:
                               //           '${ weatherResponse.currentWeather.tempF}',
                               //           fontSize: 20,
                               //         ),
                               //       ],
                               //     ),
                               //     Row(
                               //       children: [
                               //         DefaultText(
                               //           text:
                               //           '${ weatherResponse.currentWeather.tempC}',
                               //           fontSize: 20,
                               //         ),
                               //         SizedBox(width: 15,),
                               //         DefaultText(
                               //           text:
                               //           '${ weatherResponse.currentWeather.tempF}',
                               //           fontSize: 20,
                               //         ),
                               //       ],
                               //     ),
                               //     Row(
                               //       children: [
                               //         DefaultText(
                               //           text:
                               //           '${ weatherResponse.currentWeather.tempC}',
                               //           fontSize: 20,
                               //         ),
                               //         SizedBox(width: 15,),
                               //         DefaultText(
                               //           text:
                               //           '${ weatherResponse.currentWeather.tempF}',
                               //           fontSize: 20,
                               //         ),
                               //       ],
                               //     ),
                               //     Row(
                               //       children: [
                               //         DefaultText(
                               //           text:
                               //           '${ weatherResponse.currentWeather.tempC}',
                               //           fontSize: 20,
                               //         ),
                               //         SizedBox(width: 15,),
                               //         DefaultText(
                               //           text:
                               //           '${ weatherResponse.currentWeather.tempF}',
                               //           fontSize: 20,
                               //         ),
                               //       ],
                               //     ),
                               //     Row(
                               //       children: [
                               //         DefaultText(
                               //           text:
                               //           '${ weatherResponse.currentWeather.tempC}',
                               //           fontSize: 20,
                               //         ),
                               //         SizedBox(width: 15,),
                               //         DefaultText(
                               //           text:
                               //           '${ weatherResponse.currentWeather.tempF}',
                               //           fontSize: 20,
                               //         ),
                               //       ],
                               //     ),
                               //   ],
                               // )

                                Column(
                                  children: [
                                  Row(
                                    children: [
                                      DefaultText(
                                        text:
                                        '${changeTempUnit(weatherResponse.forecast.forecastday[0].day.maxtempC, weatherResponse.forecast.forecastday[0].day.maxtempF)}    ${changeTempUnit(weatherResponse.forecast.forecastday[0].day.mintempC, weatherResponse.forecast.forecastday[0].day.mintempF)}',
                                        fontSize: 12.sp,
                                      ),
                                    ],
                                  ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: [
                                        DefaultText(
                                          text:
                                          '${changeTempUnit(weatherResponse.forecast.forecastday[0].day.maxtempC, weatherResponse.forecast.forecastday[0].day.maxtempF)}    ${changeTempUnit(weatherResponse.forecast.forecastday[0].day.mintempC, weatherResponse.forecast.forecastday[0].day.mintempF)}',
                                          fontSize: 12.sp,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: [
                                        DefaultText(
                                          text:
                                          '${changeTempUnit(weatherResponse.forecast.forecastday[0].day.maxtempC, weatherResponse.forecast.forecastday[0].day.maxtempF)}    ${changeTempUnit(weatherResponse.forecast.forecastday[0].day.mintempC, weatherResponse.forecast.forecastday[0].day.mintempF)}',
                                          fontSize: 12.sp,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: [
                                        DefaultText(
                                          text:
                                          '${changeTempUnit(weatherResponse.forecast.forecastday[0].day.maxtempC, weatherResponse.forecast.forecastday[0].day.maxtempF)}    ${changeTempUnit(weatherResponse.forecast.forecastday[0].day.mintempC, weatherResponse.forecast.forecastday[0].day.mintempF)}',
                                          fontSize: 12.sp,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: [
                                        DefaultText(
                                          text:
                                          '${changeTempUnit(weatherResponse.forecast.forecastday[0].day.maxtempC, weatherResponse.forecast.forecastday[0].day.maxtempF)}    ${changeTempUnit(weatherResponse.forecast.forecastday[0].day.mintempC, weatherResponse.forecast.forecastday[0].day.mintempF)}',
                                          fontSize: 12.sp,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: [
                                        DefaultText(
                                          text:
                                          '${changeTempUnit(weatherResponse.forecast.forecastday[0].day.maxtempC, weatherResponse.forecast.forecastday[0].day.maxtempF)}    ${changeTempUnit(weatherResponse.forecast.forecastday[0].day.mintempC, weatherResponse.forecast.forecastday[0].day.mintempF)}',
                                          fontSize: 12.sp,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: [
                                        DefaultText(
                                          text:
                                          '${changeTempUnit(weatherResponse.forecast.forecastday[0].day.maxtempC, weatherResponse.forecast.forecastday[0].day.maxtempF)}    ${changeTempUnit(weatherResponse.forecast.forecastday[0].day.mintempC, weatherResponse.forecast.forecastday[0].day.mintempF)}',
                                          fontSize: 12.sp,
                                        ),
                                      ],
                                    ),
                                  ],
                                )

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final int x;
  final Hour y;
}
