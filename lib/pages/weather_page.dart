import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weathertute/models/weather_model.dart';
import 'package:weathertute/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('b7f43b4208d2d6683578f8454ae08c76');
  WeatherModel? _weather;

  //fetch weather
  _fetchWeather() async {
    //get the cuurrent city
    String cityName = await _weatherService.getCurrencyCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    //any error
    catch (e) {
      print('Error!');
    }
  }

  //weather animations

  //init state
  @override
  void initState() {
    super.initState();

    //fetch weather
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? 'Loading city...'),

            //temperature
            Text('${_weather?.temperature.round()}°C'),
          ],
        ),
      ),
    );
  }
}
