import 'package:dio/dio.dart';
import 'package:flutter_store/utils/constants.dart';
import 'package:flutter_store/utils/utility.dart';

class DioConfig {
  static final Dio _dio = Dio()

    // .. is reference instance or object _dio == new Dio();
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Accept'] = 'application/json';
          options.headers['Content-Type'] = 'application/json';
          options.baseUrl = baseURLAPI;
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) async {
          switch (e.response?.statusCode) {
            case 400:
              Utility().logger.e('Bad Request');
              break;
            case 401:
              Utility().logger.e('Unauthorized');
              break;
            case 403:
              Utility().logger.e('Forbidden');
              break;
            case 404:
              Utility().logger.e('Not Found');
              break;
            case 500:
              Utility().logger.e('Internal Server Error');
              break;
            default:
              Utility().logger.e('Something went wrong');
              break;
          }
          return handler.next(e);
        },
      ),
    );

  // method name dio is getter return instance _dio
  static Dio get dio => _dio;
}
