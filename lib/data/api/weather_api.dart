import 'package:weather_app/data/api/base_api.dart';
import 'package:weather_app/data/api/request_api.dart';
import 'package:weather_app/data/entity/city_enity.dart';
import 'package:weather_app/data/entity/weather_entity.dart';

class WeatherAPI {
  final String baseURL = 'https://api.weatherapi.com/v1';
  static const String kPathWeather = "/forecast.json";
  static const String apiKey = "05daab6e94434231a36133726222406";

  WeatherAPI._();

  static WeatherAPI? _instance;

  static WeatherAPI get instance {
    _instance ??= WeatherAPI._();
    return _instance!;
  }

  Future<Map<String, dynamic>> getWeather({String? search}) async {
    var url = "$baseURL$kPathWeather?key=$apiKey&days=7&q=$search";
    final response = await RequestAPI.instance.get(url: url);
    return {
      "location": Location.fromJson(response['location']),
      "current": Current.fromJson(response['current']),
      "forecast": Forecast.fromJson(response['forecast'])
    };
  }
}
