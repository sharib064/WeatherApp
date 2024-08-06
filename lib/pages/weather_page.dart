import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherService =
      WeatherService(apiKey: 'dd3fb8a036a3f66c488fdf992c800c4e');
  Weather? _weather;
  _fetchWeather() async {
    await weatherService.getCurrentCity();
    try {
      final weather = await weatherService.getWeather();
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  String getAnimation(String? mainCondition) {
    if (mainCondition == null) return 'lib/assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'dust':
      case 'fog':
      case 'haze':
        return 'lib/assets/windy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'lib/assets/rainy.json';
      case 'thunderstorm':
        return 'lib/asstes/storm.json';
      case 'clear':
        return 'lib/assets/sunny.json';
      default:
        return 'lib/assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading data",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            Lottie.asset(getAnimation(_weather?.mainCondition)),
            Text("${_weather?.temperature.round()} °C",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            Text(_weather?.mainCondition ?? "",
                style: const TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
