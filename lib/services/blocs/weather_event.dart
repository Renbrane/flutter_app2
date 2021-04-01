import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {}

class FetchWeatherEvent extends WeatherEvent {
  @override
  List<Object> get props => null;
}
