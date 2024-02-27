import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class WheatherService {
  final Dio _dio;

  WheatherService(this._dio);

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response = await _dio.get('https://api.openweathermap.org/data/2.5/weather', queryParameters: {
      'q': city,
      'appid': '4bebc57bd85d1551542eaa5344a84430', // Replace with your OpenWeatherMap API key
    });
    return response.data;
  }
}
