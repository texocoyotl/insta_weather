import 'package:meta/meta.dart';

abstract class CityWeatherEvent {}

class GetWeatherByCityName extends CityWeatherEvent {
  final String cityName;
  final String countryCode;

  GetWeatherByCityName({@required this.cityName, @required this.countryCode});
}

class GetWeatherByGeolocation extends CityWeatherEvent {}

class AppStarted extends CityWeatherEvent {}