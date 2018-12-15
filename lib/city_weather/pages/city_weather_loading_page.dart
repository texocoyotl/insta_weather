import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: AppBar(
            title: Text('City Weather'),
          ),
          body: Stack(
            children: <Widget>[
              Opacity(
                opacity: 0.3,
                child: ModalBarrier(dismissible: false, color: Colors.grey),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],

          ));
  }


}