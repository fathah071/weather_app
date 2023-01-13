import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/weather_funtion.dart';

import 'package:weather_app/view/dashboard_screen.dart';

import '../../controller/location_provider.dart';
import '../../controller/sharedPrefernce_controller.dart';

class SplashSreen extends StatefulWidget {
  const SplashSreen({Key? key}) : super(key: key);

  @override
  State<SplashSreen> createState() => _SplashSreenState();
}

class _SplashSreenState extends State<SplashSreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      final locationProvider =
          Provider.of<LocationController>(context, listen: false);

      print(locationProvider.isPermissionGranted);

      final sharedPreferenceProvider =
          Provider.of<SharedController>(context, listen: false);
      final weatherProvider =
          Provider.of<WeatherService>(context, listen: false);
      weatherProvider.getWeatherData(
          locationProvider.latitude, locationProvider.longtitude, context);

      sharedPreferenceProvider.getWeatherData();
      _navigateToFirstPage();
    });
  }

  _navigateToFirstPage() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationController>(builder: (context, provider, child) {
      return const Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
            child: Text(
          "Lilac Flutter Assignment",
          style: TextStyle(
              fontWeight: FontWeight.w300, color: Colors.white, fontSize: 25),
        )),
      );
    });
  }
}
