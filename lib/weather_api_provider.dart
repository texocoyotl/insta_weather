import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'city_weather/city_weather_model.dart';
import 'weather_api_exception.dart';

class WeatherApiProvider {
  Client client = Client();
  final _apiKey = 'ba0e69f43d9a57453bb49be2b15ba5b5';

  Future<CityWeatherModel> fetchWeatherByPosition(double latitude, double longitude) async {
    final String url = "http://api.openweathermap.org/data/2.5/weather?appid=$_apiKey&lat=$latitude&lon=$longitude";
    print ("API Call: $url");
    final response = await client.get(url);
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return CityWeatherModel.fromJson(jsonResponse);
    } else {
      // If that call was not successful, throw an error.
      throw WeatherAPIException(jsonResponse['message']);
    }
  }

  Future<CityWeatherModel> fetchWeatherByName(String cityName, String countryCode) async {
    final String url = "http://api.openweathermap.org/data/2.5/weather?appid=$_apiKey&q=$cityName,$countryCode";
    print ("API Call: $url");
    final response = await client.get(url);
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return CityWeatherModel.fromJson(jsonResponse);
    } else {
      // If that call was not successful, throw an error.
      throw WeatherAPIException(jsonResponse['message']);
    }
  }
}