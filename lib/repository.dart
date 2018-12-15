import 'dart:async';
import 'package:insta_weather/weather_api_provider.dart';
import 'city_weather/city_weather_model.dart';

class Repository {
  final weatherApiProvider = WeatherApiProvider();

  Future<CityWeatherModel> fetchWeatherByPosition(double latitude, double longitude) => weatherApiProvider.fetchWeatherByPosition(latitude, longitude);
  Future<CityWeatherModel> fetchWeatherByName(String cityName, String countryCode) => weatherApiProvider.fetchWeatherByName(cityName, countryCode);

}