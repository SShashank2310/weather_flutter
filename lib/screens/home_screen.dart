import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/weather_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter City',
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final city = _controller.text;
                  if (city.isNotEmpty) {
                    Provider.of<WeatherProvider>(context, listen: false)
                        .fetchWeather(city)
                        .then((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeatherScreen(),
                        ),
                      );
                    });
                  }
                },
                child: const Text('Get Weather'),
              ),

              Consumer<WeatherProvider>(
                builder: (context, provider, child) {
                  if (provider.loading) {
                    return const CircularProgressIndicator();
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
