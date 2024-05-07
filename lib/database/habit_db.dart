import 'package:flutter/foundation.dart';
import 'package:for_you/database/db_user_functions.dart';
import 'package:for_you/models/habit_model.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<HabitModel>> habbitNotifierList = ValueNotifier([]);

class HabitDBFunctions extends ChangeNotifier {
//adding habbit
  Future addHabbit(HabitModel habbitname) async {
    final Box<HabitModel> box = await Hive.openBox('habbitbox');

    habbitname.userId = currentUserKey!;
    await box.add(habbitname);

    await getHabbit();

    await box.close();
  }

//getting habbbit
  Future<void> getHabbit() async {
    final Box<HabitModel> box = await Hive.openBox('habbitbox');

    // Clear the list before adding new habits
    habbitNotifierList.value = [];

    // Filter habits based on the provided userId
    final List<HabitModel> habits =
        box.values.where((habit) => habit.userId == currentUserKey).toList();

    // Add filtered habits to the notifier list
    habbitNotifierList.value.addAll(habits);

    // Notify listeners after updating the list
    habbitNotifierList.notifyListeners();

    await box.close();
  }

//editing habbit

  Future<void> editHabbit(int key, HabitModel updatedHabit) async {
    final Box<HabitModel> box = await Hive.openBox('habbitbox');
    updatedHabit.userId = currentUserKey;

    await box.put(key, updatedHabit);
    // Don't close the database here
    // await box.close();
    await getHabbit(); // Refresh the habit list
  }

  //delete habbit
  Future deleteHabbit(int key) async {
    final Box<HabitModel> box = await Hive.openBox('habbitbox');
    await box.delete(key);

    // Update the habbitNotifierList directly
    habbitNotifierList.value.removeWhere((habit) => habit.key == key);
    habbitNotifierList.notifyListeners();

    await box.close();
  }

  Future updateCompletion(DateTime date, bool status, String habbitname) async {
    //ignoring the time
    date = DateTime(date.year, date.month, date.day);
    final Box<HabitModel> box = await Hive.openBox('habbitbox');

    //?checks that each habbit contains the specific date
    final habit =
        box.values.firstWhere((element) => element.habbitName == habbitname);

    habit.habbitCompleted?[date] = status;
    await box.put(habit.key, habit);
    await box.close();
    getHabbit();
  }
}
