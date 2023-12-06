import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Utility {
  // Logger
  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  // Test Logger
  void testLogger() {
    logger.t('Verbose log');
    logger.d('Debug log');
    logger.i('Info log');
    logger.w('Warning log');
    logger.e('Error log');
    logger.f('What a terrible failure log');
  }

  // Check Network Connection
  static Future<dynamic> checkNetwork() async {
    var checkNetwork = await Connectivity().checkConnectivity();

    if (checkNetwork == ConnectivityResult.none) {
      return false;
    } else if (checkNetwork == ConnectivityResult.mobile) {
      return 'mobile';
    } else if (checkNetwork == ConnectivityResult.wifi) {
      return 'wifi';
    }

    return false;
  }

  // Alert Dialog
  static showAlertDialog(context, title, content) {
    AlertDialog buildAlertDialog(Color backgroundColor, IconData icon) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: backgroundColor,
              radius: 35,
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
            ),
            Text(content),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ตกลง'),
            ),
          ),
        ],
      );
    }

    switch (title) {
      case "success":
        return showDialog(
          context: context,
          builder: (BuildContext context) => FractionallySizedBox(
              heightFactor: 0.4,
              child: buildAlertDialog(Colors.green[700]!, Icons.check)),
        );
      case "error":
        return showDialog(
          context: context,
          builder: (BuildContext context) => FractionallySizedBox(
              heightFactor: 0.4,
              child: buildAlertDialog(Colors.red[700]!, Icons.close)),
        );
      default:
        return showDialog(
          context: context,
          builder: (BuildContext context) => FractionallySizedBox(
              heightFactor: 0.4,
              child: buildAlertDialog(Colors.blue[700]!, Icons.info_outline)),
        );
    }
  }

  // Shared Preferences
  static SharedPreferences? _preferences;
  static Future initSharedPrefs() async =>
      _preferences = await SharedPreferences.getInstance();

  // Get Shared Preferences
  static dynamic getSharedPreference(String key) {
    if (_preferences == null) return null;
    return _preferences!.get(key);
  }

  // Set Shared Preferences
  static Future<bool> setSharedPreference(String key, dynamic value) async {
    if (_preferences == null) return false;
    if (value is String) return await _preferences!.setString(key, value);
    if (value is int) return await _preferences!.setInt(key, value);
    if (value is bool) return await _preferences!.setBool(key, value);
    if (value is double) return await _preferences!.setDouble(key, value);
    if (value is Map) {
      String stringify = jsonEncode(value);
      return await _preferences!.setString(key, stringify);
    }
    return false;
  }

  // Remove Shared Preferences
  static Future<bool> removeSharedPreference(String key) async {
    if (_preferences == null) return false;
    return await _preferences!.remove(key);
  }

  // Clear Shared Preferences
  static Future<bool> clearSharedPreference() async {
    if (_preferences == null) return false;
    return await _preferences!.clear();
  }

  // Check Shared Preferences
  static Future<bool> checkSharedPreference(String key) async {
    if (_preferences == null) return false;
    return _preferences!.containsKey(key);
  }
}
