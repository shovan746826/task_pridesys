import 'dart:convert';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreferences? _sharedPreferences;

  SharedPreference() {
    // init();
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    debugPrint('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  static clearSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  static void storeNextPage(String url) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('nextPage', url);
  }
  static Future<String?> getNextPage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('nextPage');
  }

}
