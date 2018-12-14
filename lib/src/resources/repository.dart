import 'dart:async';
import 'weather_api_provider.dart';
import '../models/item_model.dart';

class Repository {
  final weatherApiProvider = WeatherApiProvider();

  Future<void> fetchWeather() => weatherApiProvider.fetchWeather();
}