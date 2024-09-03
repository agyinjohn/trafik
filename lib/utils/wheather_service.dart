// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class WeatherService {
//   final String apiKey =
//       '7bfa5331a160db3679b26358d63e0b33'; // Replace with your OpenWeather API key

//   Future<Map<String, dynamic>> fetchWeather(String city) async {
//     final response = await http.get(Uri.parse(
//         'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load weather data');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey =
      '7bfa5331a160db3679b26358d63e0b33'; // Replace with your OpenWeather API key

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<Map<String, dynamic>> fetchWeatherByCoordinates(
      double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
