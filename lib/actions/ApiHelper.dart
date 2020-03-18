import 'dart:io';
import 'dart:convert' show json;
import 'dart:ui' as ui;

import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {

  static SharedPreferences prefs;
  static bool includeAdult;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    includeAdult = prefs.getBool('adultItems') ?? false;
  }

}