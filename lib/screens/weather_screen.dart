import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/home_screen.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Consumer<WeatherProvider>(builder: (context, provider, child){
          return Text(provider.weather == null ? '🙏  Welcome   🙏 !!' : "☁️   Weather Page    ☁️");
        },),
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              final city = Provider.of<WeatherProvider>(context, listen: false)
                  .weather!
                  .cityName;
              Provider.of<WeatherProvider>(context, listen: false)
                  .fetchWeather(city);
            },
          ),
        ],
      ),
      body: Center(
        child: Consumer<WeatherProvider>(
          builder: (context, provider, child) {
            if (provider.loading) {
              return CircularProgressIndicator();
            }
            if (provider.error.isNotEmpty) {
              return Text(
                provider.error,
                textAlign: TextAlign.center,
              );
            }
            if (provider.weather == null) {
              return Text(
                'Welcome to my weather app !! ✨✨\n Kindly tap the 🔍 icon above to proceed.\n',
                textAlign: TextAlign.center,
              );
            }

            final weather = provider.weather!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weather.cityName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${weather.temp}°C',
                  style: TextStyle(fontSize: 48),
                ),
                Text(weather.condition),
                Image.network(
                  'http://openweathermap.org/img/wn/${weather.icon}.png',
                ),
                Text('Humidity: ${weather.humidity}%'),
                Text('Wind Speed: ${weather.windSpeed} m/s'),
              ],
            );
          },
        ),
      ),
    );
  }
}
