import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:insta_weather/city_weather/city_weather.dart';

class CityWeatherFormContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CityWeatherFormContentState();
  }
}

class CityWeatherFormContentState extends State<CityWeatherFormContent> {
  final _formKey = GlobalKey<FormState>();

  final _countries = const {
    "CA": "Canada",
    "MX": "Mexico",
    "US": "United States",
  };

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedCountryKey;
  String _cityName;

  @override
  void initState() {
    _dropDownMenuItems = getCountryMenuItems();
    _selectedCountryKey = "US";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DropdownMenuItem<String>> getCountryMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    _countries.forEach((key, name) =>
        items.add(new DropdownMenuItem(value: key, child: new Text(name))));
    return items;
  }

  void changedDropDownItem(String selectedCountry) {
    setState(() {
      _selectedCountryKey = selectedCountry;
    });
  }

  void showSnack(String text){
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    final CityWeatherBloc cityWeatherBloc = BlocProvider.of<CityWeatherBloc>(
        context);

    return BlocBuilder<CityWeatherEvent, CityWeatherState>(
        bloc: cityWeatherBloc,
        builder: (BuildContext context, CityWeatherState state) {

          if (state.error.isNotEmpty){
            _onWidgetDidBuild(() {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }

          return _content(cityWeatherBloc, state);
        });
  }

  Widget _content(CityWeatherBloc bloc, CityWeatherState state) =>
    Form(
          key: _formKey,
          child: Container(
              padding: EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.location_city),
                      labelText: 'City Name ',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a valid city name';
                      }
                    },
                    onSaved: (value){
                      _cityName = value;
                    },
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.landscape),
                      hintText: 'What do people call you?',
                      labelText: 'Country',
                    ),
                    value: _selectedCountryKey,
                    items: _dropDownMenuItems,
                    onChanged: changedDropDownItem,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, we want to show a
                          _formKey.currentState.save();
                          bloc.onGetCityWeatherByCityName(_cityName, _selectedCountryKey);
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                  Text("Or"),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child:
                      RaisedButton(
                        onPressed: bloc.onGetCityWeatherByGeolocation,
                        child: Text('Use my current location'),
                      )),
                ],
              ))
    );


  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

}
