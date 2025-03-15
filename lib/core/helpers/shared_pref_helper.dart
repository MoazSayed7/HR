import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._();

  /// Gets an String List values from SharedPreferences with given [key].
  static Future<List<String>> getStringList(String key) async {
    debugPrint('SharedPrefHelper : getStringList with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(key) ?? [];
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  static setStringList(String key, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    debugPrint("SharedPrefHelper : setStringList with key : $key and value : $value");
    await sharedPreferences.setStringList(key, value);
  }
}
