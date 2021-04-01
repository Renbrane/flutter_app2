import 'package:flutter/material.dart';
import 'package:flutter_app2/generated/l10n.dart';
import 'package:flutter_app2/services/api_results.dart';
import 'package:flutter_app2/services/blocs/weather_bloc.dart';
import 'package:flutter_app2/services/blocs/weather_event.dart';
import 'package:flutter_app2/services/blocs/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app2/models/forecast_model.dart';
import 'package:flutter_app2/models/weather_model.dart';
import 'package:flutter_app2/widgets/weather.dart';
import 'package:flutter_app2/widgets/weather_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherBloc weatherBloc;

  @override
  void initState() {
    super.initState();
    weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(FetchWeatherEvent());
  }

  String dropdownValue = 'Hourly';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
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
                    items: <String>[
                      S.of(context).dropdownMenuVarOne,
                      S.of(context).dropdownMenuVarTwo,
                    ].map<DropdownMenuItem<String>>((String newValue) {
                      return DropdownMenuItem<String>(
                        value: newValue,
                        child: Text(newValue),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
            body: BlocProvider(
              create: (context) => WeatherBloc(
                ApiResultsImpl(),
              ),
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherInitialState ||
                      state is WeatherLoadingState) {
                    return buildLoading();
                  } else if (state is WeatherErrorState) {
                    return buildErrorUI(state.message);
                  } else if (state is WeatherLoadedState &&
                      dropdownValue == S.of(context).dropdownMenuVarOne) {
                    return buildHourlyUI(state.weatherData, state.forecastData);
                  } else if (state is WeatherLoadedState &&
                      dropdownValue == S.of(context).dropdownMenuVarTwo) {
                    return buildDailyUI(state.weatherData, state.forecastData);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildErrorUI(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        message,
        style: TextStyle(color: Colors.red),
      ),
    ),
  );
}

Widget buildHourlyUI(WeatherData weatherData, ForecastData forecastData) {
  return Center(
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
            ],
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200.0,
              child: forecastData != null
                  ? ListView.builder(
                      itemCount: forecastData.listHourly.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => HourlyWeatherItem(
                        weather: forecastData.listHourly.elementAt(index),
                      ),
                    )
                  : Container(),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildDailyUI(WeatherData weatherData, ForecastData forecastData) {
  return Center(
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
            ],
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200.0,
              child: forecastData != null
                  ? ListView.builder(
                      itemCount: forecastData.listDaily.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => DailyWeatherItem(
                        weather: forecastData.listDaily.elementAt(index),
                      ),
                    )
                  : Container(),
            ),
          ),
        ),
      ],
    ),
  );
}
