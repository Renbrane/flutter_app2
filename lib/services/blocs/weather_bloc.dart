import 'package:bloc/bloc.dart';
import 'package:flutter_app2/models/forecast_model.dart';
import 'package:flutter_app2/models/weather_model.dart';
import 'package:flutter_app2/services/api_results.dart';
import 'package:flutter_app2/services/blocs/weather_event.dart';
import 'package:flutter_app2/services/blocs/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  ApiResults apiResults;

  WeatherBloc(this.apiResults);

  @override
  WeatherState get initialState => WeatherInitialState();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherEvent) {
      yield WeatherLoadedState();
      try {
        WeatherData weatherData = await apiResults.getWeatherData();
        ForecastData forecastData = await apiResults.getForecastData();
        yield WeatherLoadedState(
          weatherData: weatherData,
          forecastData: forecastData,
        );
      } catch (e) {
        yield WeatherErrorState(
          message: e.toString(),
        );
      }
    }
  }
}
