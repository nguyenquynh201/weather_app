import 'package:dio/dio.dart';
import 'package:weather_app/data/api/base_api.dart';

class RequestAPI extends BaseAPI {



  RequestAPI._();

  static RequestAPI? _instance;

  static RequestAPI get instance {
    _instance ??= RequestAPI._();
    return _instance!;
  }

  @override
  Future get({required String url}) async {
    try {
      final response = await dio.get(url);
      return response.data;
    } on DioError catch (error) {
      print(error);
    }
  }

  @override
  Future post({required String url, data}) async {
    try {
      final response = await dio.post( url, data: data);
      return response.data;
    } on DioError catch (error) {
      print(error);
    }
  }
}
