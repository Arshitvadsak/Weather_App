import 'package:flutter/material.dart';
import 'package:weather_app/views/screens/home_page.dart';

void main(){
  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
      },
    )
  );
}
