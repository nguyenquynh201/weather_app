import 'package:dio/dio.dart';

abstract class BaseAPI {

  final Dio dio = Dio();
  Future<dynamic> get({required String url});
  Future<dynamic> post({required String url , dynamic data});

}