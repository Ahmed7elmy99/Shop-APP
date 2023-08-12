import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response?> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options = BaseOptions(headers: {
      'Lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    });
    final response = await dio.get(
      url,
      queryParameters: query,
    );
    return response;
  }

  static Future<Response?> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {'Lang': lang, 'Authorization': token, 'Content-Type': 'application/json'};
    final response = await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
    return response;
  }
  static Future<Response?> PutData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {'Lang': lang, 'Authorization': token, 'Content-Type': 'application/json'};
    final response = await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
    return response;
  }
}
