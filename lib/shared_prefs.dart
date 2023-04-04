import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferenceHelper {
  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static const _kAccessToken = 'accessToken';
  static const _kMobile = 'mobile';
  static const _kName = 'name';
  static const _kFatherName = 'fatherName';
  static const _kCurrentState = 'currentState';

  static Future<bool>? setAccessToken(int value) => _prefsInstance?.setInt(_kAccessToken, value);

  static int? getAccessToken() => _prefsInstance?.getInt(_kAccessToken);

  // static Future<bool>? setName(String value) => _prefsInstance.setString(_kName, value);
  //
  // static String? getName() => _prefsInstance.getString(_kMobile);
  //
  // static Future<bool>? setMobile(String value) => _prefsInstance.setString(_kMobile, value);
  //
  // static String? getMobile() => _prefsInstance.getString(_kName);
  //
  // static Future<bool>? setFatherName(String value) => _prefsInstance.setString(_kFatherName, value);
  //
  // static String? getFatherName() => _prefsInstance.getString(_kFatherName);
  //
  // static Future<bool>? setCurrentState(String value) => _prefsInstance.setString(_kCurrentState, value);
  //
  // static String? getCurrentState() => _prefsInstance.getString(_kCurrentState);

  static void clearAll() {
    _prefsInstance?.clear();
  }
}