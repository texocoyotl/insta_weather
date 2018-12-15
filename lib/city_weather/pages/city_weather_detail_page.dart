import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:insta_weather/city_weather/city_weather.dart';

class CityWeatherDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CityWeatherDetailsPageState();
  }
}

class CityWeatherDetailsPageState extends State<CityWeatherDetailsPage> {


  bool useMetric = false;
  void onMetricSwitchChanged(bool value) => setState(() => useMetric = value);

  @override
  Widget build(BuildContext context) {
    final CityWeatherBloc cityWeatherBloc =
        BlocProvider.of<CityWeatherBloc>(context);

    return BlocBuilder<CityWeatherEvent, CityWeatherState>(
        bloc: cityWeatherBloc,
        builder: (BuildContext context, CityWeatherState state) {
          return _content(state, useMetric);
        });
  }

  Widget _content(CityWeatherState state, bool useMetric) =>
      Scaffold(
          appBar: AppBar(
            title: Text('Weather on ${state.cityWeatherModel.cityName}'),
          ),
          body: Padding(
              padding: EdgeInsets.all(16) ,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.wb_sunny),
                title: Text("Condition"),
                trailing: Text(state.cityWeatherModel.condition),
              ),
              Divider(),
              ListTile(
                leading: const Icon(Icons.gradient),
                title:  Text("Current Temperature"),
                trailing: Text(state.cityWeatherModel.getTemperature(useMetric)),
              ),
              Divider(),
              ListTile(
                leading: const Icon(Icons.vertical_align_top),
                title: Text("Max Temperature"),
                trailing: Text(state.cityWeatherModel.getMaxTemperature(useMetric)),
              ),
              Divider(),
              ListTile(
                leading: const Icon(Icons.vertical_align_bottom),
                title: Text("Min Temperature"),
                trailing: Text(state.cityWeatherModel.getMinTemperature(useMetric)),
              ),
                 SwitchListTile(
                  value: useMetric,
                  onChanged: onMetricSwitchChanged,
                  title: new Text('Use metric system?', style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                )




            ],
          )));
}
