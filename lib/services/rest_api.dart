import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_store/models/product_model.dart';
import 'package:flutter_store/services/dio_config.dart';
import 'package:flutter_store/utils/utility.dart';

class CallAPI {
  // Dio Instance
  final Dio _dio = DioConfig.dio;
  final Dio _dioWithAuth = DioConfig.dioWithAuth;

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

  // Get All Product API
  Future<List<ProductModel>> getAllProducts() async {
    final response = await _dioWithAuth.get('products');
    if (response.statusCode == 200) {
      Utility().logger.d(response.data);
      final List<ProductModel> products = productModelFromJson(
        json.encode(response.data),
      );
      return products;
    }
    throw Exception('Failed to load products');
  }
}
