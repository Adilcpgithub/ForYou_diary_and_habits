import 'package:flutter/material.dart';

class Habit {
  final int id;
  final String name;
  bool completed;

  Habit({required this.id, required this.name, this.completed = false});
}

class HabitTrackerScreen extends StatefulWidget {
  const HabitTrackerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HabitTrackerScreenState createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends State<HabitTrackerScreen> {
  late List<DateTime> days;
  late List<List<Habit?>> habitsForDays; // Nullable habit list
  late List<Habit> allHabits;

  @override
  void initState() {
    super.initState();
    // Generate dates for the last 7 days
    days = List.generate(
        7, (index) => DateTime.now().subtract(Duration(days: index)));
    // Example habits (adjust as needed)
    allHabits = [
      Habit(id: 1, name: 'Exercise'),
      Habit(id: 2, name: 'Read'),
      Habit(id: 3, name: 'Meditate'),
    ];
    // Initialize habitsForDays list with null values
    habitsForDays = List.generate(
        days.length, (index) => List<Habit?>.filled(allHabits.length, null));
  }

  void toggleHabit(int dayIndex, int habitIndex) {
    setState(() {
      habitsForDays[dayIndex][habitIndex]?.completed =
          !(habitsForDays[dayIndex][habitIndex]?.completed ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, dayIndex) {
          final day = days[dayIndex];
          return Column(
            children: [
              Text(
                '${day.year}-${day.month}-${day.day}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(allHabits.length, (habitIndex) {
                    final habit = habitsForDays[dayIndex][habitIndex];
                    return HabitCard(
                      habit: habit ??
                          allHabits[
                              habitIndex], // Display habit if set, otherwise display default habit
                      onToggle: () => toggleHabit(dayIndex, habitIndex),
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HabitCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onToggle;

  const HabitCard({
    super.key,
    required this.habit,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onToggle,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              habit.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Checkbox(
              value: habit.completed,
              onChanged: (_) => onToggle(),
            ),
          ],
        ),
      ),
    );
  }
}
