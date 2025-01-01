import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:varzish/data/30_days_plan.dart';
import 'package:varzish/models/plan.dart';

const planKey = "planKey";
Future<void> savePlanLocal(List<Plan> plan) async {
  final pref = await SharedPreferences.getInstance();
  final jsonString = jsonEncode(plan.map((e) => e.toJson()).toList());
  await pref.setString(planKey, jsonString);
}

Future<List<Plan>> getPlanLocal() async {
  final pref = await SharedPreferences.getInstance();
  final jsonString = pref.getString(planKey);
  if (jsonString != null) {
    final jsonMap = jsonDecode(jsonString) as List;
    return jsonMap.map((e) => Plan.fromJson(e)).toList();
  }
  return planData;
}
