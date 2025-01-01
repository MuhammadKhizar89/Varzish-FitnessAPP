import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:varzish/models/userInfo.dart';

const userInfoKey = "userInfo";
Future<void> saveUserInfoLocal(Userinfo userInfo) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = jsonEncode(userInfo.toJson());
  await prefs.setString(userInfoKey, jsonString);
}

Future<Userinfo?> getUserInfo() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString(userInfoKey);
  if (jsonString != null) {
    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return Userinfo.fromJson(jsonMap);
  }
  return null;
}

Future<void> deleteUserInfoLocal() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString(userInfoKey);
  if (jsonString != null) {
    await prefs.remove(userInfoKey);
  }
}
