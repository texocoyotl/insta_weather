import 'package:flutter/material.dart';
import 'ui/location_search.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather By City'),
        ),
        body: LocationSearch(),
      ),
    );
  }
}
