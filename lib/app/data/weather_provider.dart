import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherProvider {
  final _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final apiKey = dotenv.env['OPENWEATHER_API_KEY'];
    final uri = Uri.parse("$_baseUrl?q=$city&appid=$apiKey&units=metric");

    print('🔍 [API 호출] URL: $uri');
    print('🔑 [API KEY] $apiKey');

    try {
      final res = await http.get(uri);

      print('📥 [HTTP 응답 상태] ${res.statusCode}');
      print('📦 [응답 바디] ${res.body}');

      if (res.statusCode == 200) {
        return json.decode(res.body);
      } else {
        throw Exception('API 호출 실패 (상태 코드: ${res.statusCode})\n본문: ${res.body}');
      }
    } catch (e) {
      print('❌ [API 예외] $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchWeatherByCoordinates({
    required double lat,
    required double lon,
  }) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=YOUR_API_KEY&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('날씨 데이터를 불러올 수 없습니다.');
    }
  }


}
