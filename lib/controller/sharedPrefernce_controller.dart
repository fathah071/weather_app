import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedController extends ChangeNotifier {
  String location = '';
  String temperatureCelsius = '';
  String weatherCondition = '';
  String humidity = '';
  String cloud = "";
  String feelsLikeCelsius = "";
  String windSpeed = '';
  

  Future<void> saveWeatherData(String location, String temperatureCelsius, String weatherCondition, String humidity,
      dynamic cloud, String feelsLikeCelsius, String windSpeed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('location', location);
    await prefs.setString('temperatureCelsius', temperatureCelsius);
    await prefs.setString('weatherCondition', weatherCondition);
    await prefs.setString('humidity', humidity);
    await prefs.setString('cloud', cloud);
    await prefs.setString('feelsLikeCelsius', feelsLikeCelsius);
    await prefs.setString('windSpeed', windSpeed);
  

    notifyListeners();
  }

  Future<void> getWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    
    location = prefs.getString('location') ?? '';
    temperatureCelsius = prefs.getString('temperatureCelsius') ?? '';
    weatherCondition = prefs.getString('weatherCondition') ?? '';
    humidity = prefs.getString('humidity') ?? "";
    cloud = prefs.getString('cloud') ?? '';
    feelsLikeCelsius = prefs.getString('feelsLikeCelsius') ?? '';
    windSpeed = prefs.getString('windSpeed') ?? "";
    notifyListeners();
  }

  Future<void> removeToken() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
   
    notifyListeners();
  }
}
