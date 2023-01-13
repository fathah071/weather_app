import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather_app/controller/sharedPrefernce_controller.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherService extends ChangeNotifier {
  WeatherModel? weatherData;
  Future<WeatherModel> getWeatherData(
      String latitude, String longitude, BuildContext context) async {
    print(latitude.toString());
    final sharedPrefernceProvider =
        Provider.of<SharedController>(context, listen: false);
    try {
      final response = await http.get(Uri.parse(
          "http://api.weatherapi.com/v1/current.json?key=c0dbb6f1794640eeabf103014222805&q=$latitude,$longitude&aqi=no"));
      final weatherModel = weatherModelFromJson(response.body);
      if (response.statusCode == 200) {
        weatherData = weatherModel;
        //save weather data to local storage
        sharedPrefernceProvider.saveWeatherData(
            weatherModel!.location!.name!,
            weatherModel.current!.tempC.toString(),
            weatherModel.current!.condition!.text!,
            weatherModel.current!.humidity.toString(),
            weatherModel.current!.cloud.toString(),
            weatherModel.current!.feelslikeC.toString(),
            weatherModel.current!.windKph.toString());

        return weatherModel;
      } else {
        throw Exception("Can not get weather");
      }
    } catch (e) {
      rethrow;
    }
  }
}
