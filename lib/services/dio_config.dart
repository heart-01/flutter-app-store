import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
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
          debugPrint('Bad Request');
          break;
        case 401:
          debugPrint('Unauthorized');
          break;
        case 403:
          debugPrint('Forbidden');
          break;
        case 404:
          debugPrint('Not Found');
          break;
        case 500:
          debugPrint('Internal Server Error');
          break;
        default:
          debugPrint('Something went wrong');
          break;
      }
      return handler.next(e);
    }));

  // method name dio is getter return instance _dio
  static Dio get dio => _dio;
}
