import 'package:flutter/material.dart';
import 'package:for_you/database/habit_db.dart';
import 'package:for_you/models/habit_model.dart';

class ShowingHabbit extends StatelessWidget {
  final TextEditingController habbitNameController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final HabitModel? habit;

  ShowingHabbit({
    super.key,
    this.habit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: habbitNotifierList,
            builder: (BuildContext context, value, Widget? child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 240),
                    child: Text(
                      habit?.habbitName ?? '',
                      style:
                          const TextStyle(color: Colors.purple, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Text(
                        habit?.habbitQuestion ?? '',
                        style:
                            const TextStyle(color: Colors.purple, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
