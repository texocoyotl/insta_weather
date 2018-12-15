import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:insta_weather/city_weather/city_weather.dart';
import 'package:insta_weather/repository.dart';
import '../weather_api_exception.dart';

class CityWeatherBloc extends Bloc<CityWeatherEvent, CityWeatherState> {

  final _repository = Repository();

  void onAppStart() {
    dispatch(AppStarted());
  }

  void onGetCityWeatherByGeolocation() {
    dispatch(GetWeatherByGeolocation());
  }

  void onGetCityWeatherByCityName(String cityName, String countryCode){
    dispatch(GetWeatherByCityName(cityName: cityName, countryCode: countryCode));
  }

  @override
  CityWeatherState get initialState => CityWeatherState.initial();

  @override
  Stream<CityWeatherState> mapEventToState(CityWeatherState currentState,
      CityWeatherEvent event) async* {
    if (event is AppStarted) {
      yield CityWeatherState.initial();
    }

    if (event is GetWeatherByGeolocation) {
      yield CityWeatherState.loading();

      try {
        Position position = await Geolocator().getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium);

        List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
            position.latitude, position.longitude);

        if (placemark == null || placemark.length == 0) {
          yield CityWeatherState.withError(
              "No city data found for this location.");
        }

        CityWeatherModel cityWeatherModel = await _repository.fetchWeatherByPosition(position.latitude, position.longitude);

        yield CityWeatherState.withData(cityWeatherModel);

      } on WeatherAPIException catch(e){
        yield CityWeatherState.withError("Network Error: ${e.message}");
      } on Exception catch(e){
        yield CityWeatherState.withError(e.toString());
      }
    }

    if (event is GetWeatherByCityName){
      try {
        CityWeatherModel cityWeatherModel = await _repository.fetchWeatherByName(event.cityName, event.countryCode);

        yield CityWeatherState.withData(cityWeatherModel);

      } on WeatherAPIException catch(e){
        yield CityWeatherState.withError("Network Error: ${e.message}");
      } on Exception catch(e){
        yield CityWeatherState.withError(e.toString());
      }
    }
  }

}