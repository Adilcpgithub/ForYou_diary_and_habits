import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'habit_model.g.dart';

@HiveType(typeId: 2)
class HabitModel extends HiveObject {
  @HiveField(0)
  String habbitName;

  @HiveField(1)
  String? habbitQuestion;

  @HiveField(2)
  late Map<DateTime, bool>? habbitCompleted;

  @HiveField(3)
  TimeOfDay? remainder;

  @HiveField(4)
  late String? userId;

  HabitModel(
      {required this.habbitName,
      this.habbitQuestion,
      Map<DateTime, bool>? habbitCompleted,
      this.remainder,
      this.userId})
      :
        //?creating a empty map
        habbitCompleted = habbitCompleted ?? {};
}
