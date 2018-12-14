import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../resources/repository.dart';

class LocationSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LocationSearchState();
  }
}

class LocationSearchState extends State<LocationSearch> {
  final _formKey = GlobalKey<FormState>();
  final _repository = Repository();

  final _countries = const {
    "CA": "Canada",
    "MX": "Mexico",
    "US": "United States",
  };

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedCountryKey;

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

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    showSnack(position.latitude.toString());
  }

  Future<void> getWeatherByCityName() async{
    _repository.fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                        // If the form is valid, we want to show a Snackbar
                        getWeatherByCityName();
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
                  onPressed: getCurrentLocation,
                  child: Text('Use my current location'),
                )),
              ],
            )));
  }
}
