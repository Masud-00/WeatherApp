import 'package:flutter/material.dart';
import 'package:weatherapp/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(context)=>home(),
    },
  ));
}



