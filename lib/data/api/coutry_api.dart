import 'package:weather_app/data/api/request_api.dart';
class CountryAPI {
  static const String kPath =
      "http://www.geognos.com/api/en/countries/info/all.json";

  CountryAPI._();

  static CountryAPI? _instance;

  static CountryAPI get instance {
    _instance ??= CountryAPI._();
    return _instance!;
  }

  Future<Map<String, dynamic>> getAPICountry() async {
    final response = await RequestAPI.instance.get(url: kPath);
    return {
      "StatusMsg": response["StatusMsg"],
      "Results": List.from(response["Results"])
    };
  }
}
