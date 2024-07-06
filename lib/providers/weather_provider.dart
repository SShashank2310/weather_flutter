import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _loading = false;
  String _error = '';

  Weather? get weather => _weather;

  bool get loading => _loading;

  String get error => _error;

  Future<void> fetchWeather(String city) async {
    _loading = true;
    _error = '';
    notifyListeners();


    try{
      final data = await WeatherService().fetchWeather(city);
      _weather = Weather.fromJson(data);
      _saveCity(city);
    } catch (e){
      // _error = 'Unable to fetch weather details.\nPlease try again with a valid city name.';
      _error = e.toString();
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> _saveCity(String city)async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('last_city', city);
  }

  Future<void> loadLastCity()async{
    final prefs= await SharedPreferences.getInstance();
    final city = prefs.getString('last_city');
    if(city!=null){
      await fetchWeather(city);
    }
  }
}
