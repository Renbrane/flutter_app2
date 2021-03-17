import 'package:flutter_app2/model/weatherModel.dart';

class ForecastData {
  final List listHourly;
  final List listDaily;

  ForecastData({this.listHourly, this.listDaily});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    List listHourly = new List();
    List listDaily = new List();


    for (dynamic e in json['hourly']) {
      HourlyWeatherData w = new HourlyWeatherData(
          date: new DateTime.fromMillisecondsSinceEpoch(e['dt'] * 1000,
              isUtc: false),
          temp: e['temp'].toDouble(),
          main: e['weather'][0]['main'],
          icon: e['weather'][0]['icon']);
      listHourly.add(w);
    }
    for (dynamic c in json['daily']) {
      DailyWeatherData w = new DailyWeatherData(
          date: new DateTime.fromMillisecondsSinceEpoch(c['dt'] * 1000,
              isUtc: false),
          temp: c['temp']['day'].toDouble(),
          main: c['weather'][0]['main'],
          icon: c['weather'][0]['icon']);
      listDaily.add(w);
    }

    return ForecastData(
      listHourly: listHourly,
      listDaily: listDaily,
    );
  }
}