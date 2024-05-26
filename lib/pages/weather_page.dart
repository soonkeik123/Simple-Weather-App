import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  String getWeatherAnimation(String? mainCondition) {
    if(mainCondition == null) return 'assets/sunny.json';

    switch(mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloudy.json';
      case 'mist':
        return 'assets/cloudy.json';
      case 'smoke':
        return 'assets/slightly-cloud.json';
      case 'haze':
        return 'assets/cloudy.json';
      case 'dust':
        return 'assets/cloudy.json';
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
        return 'assets/rain.json';
      case 'drizzle':
        return 'assets/rain.json';
      case 'shower rain': 
        return 'assets/rain.json';
      case 'thunderstorm': 
        return 'assets/thunder-rain.json';
      case 'clear': 
        return 'assets/sunny.json';
      default: 
        return 'assets/sunny.json';
    }
  }

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

            // animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
        
            // temperature
            Text('${_weather?.temperature.round()}°C'),

            // weather condition
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}