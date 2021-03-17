import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app2/generated/l10n.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_app2/model/forecastModel.dart';
import 'package:flutter_app2/model/weatherModel.dart';
import 'package:flutter_app2/widgets/weather.dart';
import 'package:flutter_app2/widgets/weatherItem.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;

  loadWeather() async {
    setState(() {
      isLoading = true;
    });
    Position position;
    try {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    } catch (e) {
      print(e);
    }

    if (position != null) {
      final lat = position.latitude;
      final lon = position.longitude;

      final weatherResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/weather?APPID=31a8c21461ac85fed5f7827a2ac45e17&lat=${lat.toString()}&lon=${lon.toString()}&units=metric');
      final forecastResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/onecall?lat=${lat.toString()}&lon=${lon.toString()}&APPID=31a8c21461ac85fed5f7827a2ac45e17&units=metric');


      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        return setState(() {
          weatherData = new WeatherData.fromJson(jsonDecode(weatherResponse.body));
          forecastData = new ForecastData.fromJson(jsonDecode(forecastResponse.body));
          isLoading = false;
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadWeather();
  }
  String dropdownValue = 'Hourly';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).homeScreenAppBarText),
        actions: <Widget>[
          RaisedButton(
            color: Colors.black,
            child: DropdownButton<String>(
              value: dropdownValue,
              underline: Container(),
              icon: Icon(Icons.arrow_downward),
              iconSize: 20.0,
              iconEnabledColor: Colors.red,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>[S.of(context).dropdownMenuVarOne, S.of(context).dropdownMenuVarTwo].map<DropdownMenuItem<String>>((String newValue) {
                return DropdownMenuItem<String>(
                  value: newValue,
                  child: Text (newValue),
                );
              }).toList(),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: weatherData != null
                        ? Weather(weather: weatherData)
                        : Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isLoading
                        ? CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor:
                                new AlwaysStoppedAnimation(Colors.white),
                          )
                        : IconButton(
                            icon: new Icon(Icons.refresh),
                            tooltip: 'Refresh',
                            onPressed: loadWeather,
                            color: Colors.white,
                          ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200.0,
                  child: forecastData != null && dropdownValue == S.of(context).dropdownMenuVarOne
                      ? ListView.builder(
                          itemCount: forecastData.listHourly.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => HourlyWeatherItem(
                              weather: forecastData.listHourly.elementAt(index)))
                      : Container(),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200.0,
                  child: forecastData != null && dropdownValue == S.of(context).dropdownMenuVarTwo
                      ? ListView.builder(
                      itemCount: forecastData.listDaily.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => DailyWeatherItem(
                          weather: forecastData.listDaily.elementAt(index)))
                      : Container(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


