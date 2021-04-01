import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_app2/models/forecast_model.dart';
import 'package:flutter_app2/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class ApiResults {
  dynamic getWeatherData();
  dynamic getForecastData();
}

class ApiResultsImpl implements ApiResults {
  WeatherData weatherData;
  ForecastData forecastData;

  ApiResultsImpl({this.forecastData, this.weatherData});

  @override
  getWeatherData() async {
    Position position = getPosition();
    if (position != null) {
      final weatherResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/weather?APPID=31a8c21461ac85fed5f7827a2ac45e17&lat=${position.latitude.toString()}&lon=${position.longitude.toString()}&units=metric');

      if (weatherResponse.statusCode == 200) {
        this.weatherData =
            new WeatherData.fromJson(jsonDecode(weatherResponse.body));
        return weatherData;
      }
    }
  }

  @override
  getForecastData() async {
    Position position = getPosition();
    if (position != null) {
      final forecastResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/onecall?lat=${position.latitude.toString()}&lon=${position.longitude.toString()}&APPID=31a8c21461ac85fed5f7827a2ac45e17&units=metric');
      if (forecastResponse.statusCode == 200) {
        this.forecastData =
            new ForecastData.fromJson(jsonDecode(forecastResponse.body));
        return forecastData;
      }
    }
  }

  dynamic getPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
    } catch (e) {
      print(e);
    }
    return position;
  }
}
