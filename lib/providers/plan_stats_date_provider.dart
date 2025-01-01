import 'package:flutter/material.dart';
import 'package:varzish/local_storage/date.dart';
import 'package:varzish/local_storage/plan.dart';
import 'package:varzish/models/date.dart';
import 'package:varzish/models/plan.dart';

class PlanStatsDateProvider extends ChangeNotifier {
  late List<Plan> _planList = [];
  late int _totalCalories = 0;
  late int _totalTime = 0;
  late double _planCompletion = 0.0;
  late int _todaysPlanDay = 0;
  late List<DateModel> _dateList = [];

  List<DateModel> get dateList => _dateList;
  List<Plan> get planList => _planList;
  int get totalCalories => _totalCalories;
  int get totalTime => _totalTime;
  double get planCompletion => _planCompletion;
  int get todaysPlanDay => _todaysPlanDay;

  void _calculateTodaysPlanDay() {
    _todaysPlanDay = 0;
    for (var plan in _planList) {
      if (plan.completedPercentage == 100) {
        _todaysPlanDay = plan.dayNo;
      }
    }
    if (_todaysPlanDay != 30) {
      _todaysPlanDay += 1;
    }
  }

  Future<void> initPlanList() async {
    _planList = await getPlanLocal();
    _dateList = await getDateLocal();
    _totalCalories = 0;
    _totalTime = 0;
    _planCompletion = 0.0;

    for (var plan in _planList) {
      _totalCalories += (plan.calories * plan.completedPercentage ~/ 100);
      _totalTime += (plan.time * plan.completedPercentage ~/ 100);
      _planCompletion += plan.completedPercentage;
    }
    _planCompletion = _planCompletion / 3000;
    _calculateTodaysPlanDay();
    notifyListeners();
  }

  Future<void> updatePlanList(
      List<Plan> argPlanList, List<DateModel> argDateList) async {
    await savePlanLocal(argPlanList);
    await saveDateLocal(argDateList);
    _dateList = argDateList;
    _planList = argPlanList;
    _totalCalories = 0;
    _totalTime = 0;
    _planCompletion = 0.0;
    for (var plan in argPlanList) {
      _totalCalories += (plan.calories * plan.completedPercentage ~/ 100);
      _totalTime += (plan.time * plan.completedPercentage ~/ 100);
      _planCompletion += plan.completedPercentage;
    }
    _planCompletion = _planCompletion / 3000;
    _calculateTodaysPlanDay();
    notifyListeners();
  }
}
