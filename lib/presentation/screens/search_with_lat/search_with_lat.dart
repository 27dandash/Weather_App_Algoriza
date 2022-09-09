import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:weather/weather.dart';

import '../../../constants/components/components.dart';
import 'Countrys_LatandLong.dart';


enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class SearchWithlat extends StatefulWidget {
  const SearchWithlat({Key? key}) : super(key: key);

  @override
  _SearchWithlatState createState() => _SearchWithlatState();
}

class _SearchWithlatState extends State<SearchWithlat> {
  String key = '856822fd8e22db5e1ba48c0e7d69844a';
  late WeatherFactory ws;
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  double? lat, lon;

  @override
  void initState() {
    super.initState();
    ws = WeatherFactory(key);
  }

  void queryForecast() async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _state = AppState.DOWNLOADING;
    });

    List<Weather> forecasts = await ws.fiveDayForecastByLocation(lat!, lon!);
    setState(() {
      _data = forecasts;
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  void queryWeather() async {
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });

    Weather weather = await ws.currentWeatherByLocation(lat!, lon!);
    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  Widget contentFinishedDownload() {
    return Center(
      child: ListView.separated(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_data[index].toString()),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  Widget contentDownloading() {
    return Container(
      margin: EdgeInsets.all(25),
      child: Column(children: [
        Text(
          'Fetching Weather...',
          style: TextStyle(fontSize: 20),
        ),
        Container(
            margin: EdgeInsets.only(top: 50),
            child: Center(child: CircularProgressIndicator(strokeWidth: 10)))
      ]),
    );
  }

  Widget contentNotDownloaded() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            'Press the button to Know the Weather in That Area',
          ),
        ],
      ),
    );
  }

  Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
      ? contentFinishedDownload()
      : _state == AppState.DOWNLOADING
          ? contentDownloading()
          : contentNotDownloaded();

  void _saveLat(String input) {
    lat = double.tryParse(input);
    if (kDebugMode) {
      print(lat);
    }
  }

  void _saveLon(String input) {
    lon = double.tryParse(input);
    if (kDebugMode) {
      print(lon);
    }
  }

  Widget _coordinateInputs() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              margin: const EdgeInsets.all(5),
              child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter latitude'),
                  keyboardType: TextInputType.number,
                  onChanged: _saveLat,
                  onSubmitted: _saveLat)),
        ),
        Expanded(
            child: Container(
                margin: const EdgeInsets.all(5),
                child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter longitude'),
                    keyboardType: TextInputType.number,
                    onChanged: _saveLon,
                    onSubmitted: _saveLon)))
      ],
    );
  }

  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(5),
          child: Container(
            width: 150,
            height: 40,
            child: TextButton(
              onPressed: queryWeather,
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(HexColor("#83A9E7"))),
              child: const Text(
                'Fetch weather',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Container(
            width: 150,
            height: 40,
            child: TextButton(
              onPressed: queryForecast,
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(HexColor("#83A9E7"))),
              child: const Text(
                'Fetch forecast',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: HexColor("#83A9E7"),
            title: Row(
              children: [
                IconButton(
                    onPressed: () {
                    Navigator.pop(context);
                     },
                    icon: const Icon(Icons.arrow_back_ios_new)),
                const SizedBox(
                  width: 25,
                ),
                const Text('Search Weather App'),
               Spacer(),
                IconButton(
                    onPressed: () {
                      navigateTo(context, Countrys_Lat());
                    },
                    icon: CircleAvatar(
                        radius: 15,
                        backgroundColor:Colors.white,
                        child: Icon(Icons.question_mark)))
              ],
            )),
        body: Column(
          children: <Widget>[
            _coordinateInputs(),
            _buttons(),
            SizedBox(
              height: 30,
            ),
            const Text(
              'Your Weather Output is :',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            const Divider(
              height: 20.0,
              thickness: 2.0,
            ),
            Expanded(child: _resultView())
          ],
        ),
      ),
    );
  }
}
