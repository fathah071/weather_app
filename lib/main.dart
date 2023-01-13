import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/sharedPrefernce_controller.dart';
import 'package:weather_app/controller/weather_funtion.dart';
import 'package:weather_app/view/dashboard_screen.dart';
import 'package:weather_app/view/splash_screen/splash_screen.dart';
import 'controller/location_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocationController().requestLocationPermission();
  LocationController().getposition();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LocationController()),
      ChangeNotifierProvider(create: (context) => SharedController()),
      ChangeNotifierProvider(create: (context) => WeatherService()),
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashSreen(),
    ),
  ));
}
