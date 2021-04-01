class WeatherData {
  final DateTime date;
  final String name;
  final double temp;
  final String main;
  final String icon;

  WeatherData({this.date, this.name, this.temp, this.main, this.icon});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date: new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000,
          isUtc: false),
      name: json['name'],
      temp: json['main']['temp'].toDouble(),
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
    );
  }
}

class HourlyWeatherData {
  final DateTime date;
  final double temp;
  final String main;
  final String icon;

  HourlyWeatherData({this.date, this.temp, this.main, this.icon});

  factory HourlyWeatherData.fromJson(Map<String, dynamic> hourly) {
    return HourlyWeatherData(
      date: new DateTime.fromMillisecondsSinceEpoch(hourly['dt'] * 1000,
          isUtc: false),
      temp: hourly['temp'].toDouble(),
      main: hourly['weather'][0]['main'],
      icon: hourly['weather'][0]['icon'],
    );
  }
}

class DailyWeatherData {
  final DateTime date;
  final double temp;
  final String main;
  final String icon;

  DailyWeatherData({this.date, this.temp, this.main, this.icon});

  factory DailyWeatherData.fromJson(Map<String, dynamic> daily) {
    return DailyWeatherData(
      date: new DateTime.fromMillisecondsSinceEpoch(daily['dt'] * 1000,
          isUtc: false),
      temp: daily['temp']['day'].toDouble(),
      main: daily['weather'][0]['main'],
      icon: daily['weather'][0]['icon'],
    );
  }
}
