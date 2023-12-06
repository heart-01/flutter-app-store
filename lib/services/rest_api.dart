import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_store/services/dio_config.dart';
import 'package:flutter_store/utils/utility.dart';

class CallAPI {
  // Dio Instance
  final Dio _dio = DioConfig.dio;

  // Register API
  registerAPI(data) async {
    // Check Network Connection
    if (await Utility.checkNetwork() == false) {
      return jsonEncode({'message': 'No Network Connection'});
    } else {
      try {
        final response = await _dio.post('auth/register', data: data);
        Utility().logger.d(response.data);
        return jsonEncode(response.data);
      } catch (error) {
        Utility().logger.e(error);
      }
    }
  }

  // Login API
  loginAPI(data) async {
    // Check Network Connection
    if (await Utility.checkNetwork() == false) {
      return jsonEncode({'message': 'No Network Connection'});
    } else {
      try {
        final response = await _dio.post('auth/login', data: data);
        Utility().logger.d(response.data);
        return jsonEncode(response.data);
      } catch (error) {
        Utility().logger.e(error);
      }
    }
  }
}
