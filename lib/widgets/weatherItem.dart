import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app2/model/weatherModel.dart';

class HourlyWeatherItem extends StatelessWidget {
  final HourlyWeatherData weather;

  HourlyWeatherItem({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(weather.main),
            Text('${weather.temp.toString()}°C'),
            Image.network(
                'https://openweathermap.org/img/w/${weather.icon}.png'),
            Text(new DateFormat.yMMMd().format(weather.date)),
            Text(new DateFormat.Hm().format(weather.date)),
          ],
        ),
      ),
    );
  }
}
class DailyWeatherItem extends StatelessWidget {
  final DailyWeatherData weather;

  DailyWeatherItem({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(weather.main),
            Text('${weather.temp.toString()}°C'),
            Image.network(
                'https://openweathermap.org/img/w/${weather.icon}.png'),
            Text(new DateFormat.yMMMd().format(weather.date)),
            Text(new DateFormat.Hm().format(weather.date)),
          ],
        ),
      ),
    );
  }
}
