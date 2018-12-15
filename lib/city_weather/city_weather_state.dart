import 'package:meta/meta.dart';

import 'city_weather_model.dart';

class CityWeatherState {
  final bool isLoading;
  final String error;
  final CityWeatherModel cityWeatherModel;

  const CityWeatherState({
    this.isLoading = false,
    this.error = '',
    @required this.cityWeatherModel,
  });

  factory CityWeatherState.initial() {
    return CityWeatherState(
      cityWeatherModel: null
    );
  }

  factory CityWeatherState.loading() {
    return CityWeatherState(isLoading: true, cityWeatherModel: null);
  }

  factory CityWeatherState.withData(CityWeatherModel model) {
    return CityWeatherState(
      cityWeatherModel: model
    );
  }

  factory CityWeatherState.withError(String error) {
    return CityWeatherState(error: error, cityWeatherModel: null);
  }

  @override
  String toString() => 'CityWeatherState: $isLoading ${cityWeatherModel?.cityName} $error';

}