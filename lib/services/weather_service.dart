import "dart:convert";
import "package:http/http.dart" as http;

class WeatherService{
  static const String APIKey = "1810d5f4b037b1f6ea4692c6b589d8ba";
  static const String baseUrl = 'http://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$city&appid=$APIKey&units=metric'));
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception('Unable to fetch weather details.\nPlease try again with a valid city name.');
    }
  }
}