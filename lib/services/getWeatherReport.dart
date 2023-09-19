import 'dart:convert';
import 'dart:developer';
import 'package:assessment/model/weatherModel.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<WeatherModel>?> fetchWeather(double latitude, double longitude, String apiKey) async {
    final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
    final String units = 'metric'; // You can change this to 'imperial' for Fahrenheit units

    final Uri uri = Uri.parse('${baseUrl}?lat=${latitude}&lon=${longitude}&appid=${apiKey}');

    final response = await http.get(uri);
log(response.body.toString());
log('https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=${apiKey}');
    if (response.statusCode == 200) {
      log(response.body.toString());
      final Map<String, dynamic> data = json.decode(response.body);
      final WeatherModel weather = WeatherModel.fromJson(data); // Assuming WeatherModel.fromJson creates a single WeatherModel instance

      return [weather];
    } else {
      return null;
    }
  }

}