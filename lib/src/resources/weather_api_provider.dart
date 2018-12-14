import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

class WeatherApiProvider {
  Client client = Client();
  final _apiKey = 'ba0e69f43d9a57453bb49be2b15ba5b5';

  Future<void> fetchWeather() async {
    print("entered");
    final response = await client
        .get("http://api.openweathermap.org/data/2.5/weather?appid=$_apiKey&q=Fairfax,US");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      //return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}