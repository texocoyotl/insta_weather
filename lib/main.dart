import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:insta_weather/app.dart';

void main(){
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition.toString());
  }
}