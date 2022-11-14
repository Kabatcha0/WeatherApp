import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static void init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://api.openweathermap.org/",
        receiveDataWhenStatusError: false));
  }

  static Future<Response> getData(
      {required String path, required Map<String, dynamic> query}) async {
    return await dio.get(path, queryParameters: query);
  }
}
