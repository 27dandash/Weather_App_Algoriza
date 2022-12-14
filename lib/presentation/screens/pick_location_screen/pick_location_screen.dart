import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app_algoriza/business_logic/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app_algoriza/constants/constant_methods.dart';
import 'package:weather_app_algoriza/constants/constants.dart';
import 'package:weather_app_algoriza/constants/screens.dart';
import 'package:weather_app_algoriza/data/models/responses/weather_response/weather_list_response.dart';
import 'package:weather_app_algoriza/data/source/local/my_shared_preferences.dart';
import 'package:weather_app_algoriza/data/source/local/my_shared_preferences_keys.dart';
import 'package:weather_app_algoriza/presentation/widgets/default_map.dart';
import 'package:weather_app_algoriza/presentation/widgets/default_material_button.dart';
import 'package:weather_app_algoriza/presentation/widgets/default_text.dart';

class PickLocationScreen extends StatefulWidget {
  PickLocationScreen({Key? key}) : super(key: key);

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  double? clickedMarkerLat;
  double? clickedMarkerLong;

  @override
  initState() {
    locationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            DefaultMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: appInitialCameraPosition,
              onTap: (argument) {
                setState(() {
                  clickedMarkerLat = argument.latitude;
                  clickedMarkerLong = argument.longitude;
                });
              },
              markers: clickedMarkerLat != null && clickedMarkerLong != null
                  ? {
                      Marker(
                          markerId: const MarkerId('chosenLocation'),
                          infoWindow:
                              const InfoWindow(title: 'Chosen Location'),
                          position:
                              LatLng(clickedMarkerLat!, clickedMarkerLong!)),
                    }
                  : const {},
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 4.h),
              child: BlocListener<WeatherCubit, WeatherStates>(
                listener: (context, state) {
                  if (state is GetWeatherDataSuccessState) {
                    MySharedPreferences.putBoolean(
                        key: MySharedKeys.firstTimeLocation, value: true);
                    MySharedPreferences.putString(
                        key: MySharedKeys.currentWeatherLocation,
                        value: state.location);
                    WeatherListResponse userWeatherList = WeatherListResponse();
                    userWeatherList.weatherResponse
                        .add(WeatherCubit.get(context).weatherResponse);
                    MySharedPreferences.putString(
                        key: MySharedKeys.userWeatherList,
                        value: weatherListResponseToJson(userWeatherList));
                    Navigator.pushNamedAndRemoveUntil(
                        context, HOME_SCREEN, (route) => false);
                  }
                },
                child: DefaultMaterialButton(
                    onPressed: () {
                      if (clickedMarkerLat != null ||
                          clickedMarkerLong != null) {
                        WeatherCubit.get(context).getWeatherResponse(
                            '$clickedMarkerLat,$clickedMarkerLong');
                      } else {
                        showToastMsg(
                            msg: 'choose your location',
                            toastState: ToastStates.WARNING);
                      }
                    },
                    child: DefaultText(text: 'Choose Location')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
