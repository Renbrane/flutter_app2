import 'package:flutter_app2/models/forecast_model.dart';
import 'package:flutter_app2/models/weather_model.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {}

class WeatherInitialState extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoadingState extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoadedState extends WeatherState {
  WeatherData weatherData;
  ForecastData forecastData;

  WeatherLoadedState({this.weatherData, this.forecastData});

  @override
  List<Object> get props => [weatherData, forecastData];
}

class WeatherErrorState extends WeatherState {
  String message;

  WeatherErrorState({this.message});

  @override
  List<Object> get props => [message];
}
