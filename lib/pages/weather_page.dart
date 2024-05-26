import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  // api key
  final _weatherService = WeatherService('API KEY HERE');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get the weather for city
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }catch(e){ // any errors
      print(e);
    }
  }

  // weather animation

  // init state
  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? "Loading city..."),
        
            // temperature
            Text('${_weather?.temperature.round()}°C')
          ],
        ),
      ),
    );
  }
}