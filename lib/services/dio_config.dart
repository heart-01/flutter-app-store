import 'package:dio/dio.dart';
import 'package:flutter_store/main.dart';
import 'package:flutter_store/utils/constants.dart';

class DioConfig {
  static final Dio _dio = Dio()

    // .. is reference instance or object _dio == new Dio();
    ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers['Accept'] = 'application/json';
      options.headers['Content-Type'] = 'application/json';
      options.baseUrl = baseURLAPI;
      return handler.next(options);
    }, onResponse: (response, handler) async {
      return handler.next(response); // continue
    }, onError: (DioException e, handler) async {
      switch (e.response?.statusCode) {
        case 400:
          logger.e('Bad Request');
          break;
        case 401:
          logger.e('Unauthorized');
          break;
        case 403:
          logger.e('Forbidden');
          break;
        case 404:
          logger.e('Not Found');
          break;
        case 500:
          logger.e('Internal Server Error');
          break;
        default:
          logger.e('Something went wrong');
          break;
      }
      return handler.next(e);
    }));

  // method name dio is getter return instance _dio
  static Dio get dio => _dio;
}
