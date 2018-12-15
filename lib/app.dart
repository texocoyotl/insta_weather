import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_weather/city_weather/city_weather.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  final CityWeatherBloc _cityWeatherBloc = CityWeatherBloc();

  AppState() {
    _cityWeatherBloc.onAppStart();
  }

  @override
  void dispose() {
    _cityWeatherBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CityWeatherBloc>(
      bloc: _cityWeatherBloc,
      child: MaterialApp(
        home: _rootPage(),
      ),
    );
  }

  Widget _rootPage() {
    return BlocBuilder<CityWeatherEvent, CityWeatherState>(
        bloc: _cityWeatherBloc,
        builder: (BuildContext context, CityWeatherState state) {
          Widget content = null;

          if (state.cityWeatherModel != null) {
            content = CityWeatherDetailsPage();
          } else if (state.isLoading) {
            content = LoadingPage();
          } else {
            content = CityWeatherFormPage();
          }

          return Container(
            child: content,
          );
        });
  }
}
