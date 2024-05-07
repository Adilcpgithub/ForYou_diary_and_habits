// ignore_for_file: must_be_immutable

import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:for_you/habits/homepagehabit.dart';
import 'package:for_you/screen/diary_page/entry_list.dart';
import 'package:for_you/screen/diary_page/profilpage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, this.title, required this.selectedIndex}) {
    // ignore: avoid_print
    print('okay');
  }

  final String? title;
  int selectedIndex;
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: _pages[widget.selectedIndex],
      bottomNavigationBar: BottomBarInspiredOutside(
        items: const [
          TabItem(icon: Icons.book, title: 'diary'),
          TabItem(icon: Icons.done_all, title: 'habits '),
          TabItem(icon: Icons.person, title: 'profil'),
        ],
        backgroundColor: Colors.transparent,
        color: const Color.fromARGB(255, 52, 157, 255),
        colorSelected: const Color.fromARGB(255, 255, 255, 255),
        indexSelected: widget.selectedIndex,
        onTap: (int index) {
          setState(() {
            // ignore: avoid_print
            print('dddddddd$index');
            widget.selectedIndex = index;
          });
        },
        top: -28,
        animated: false,
        itemStyle: ItemStyle.circle,
        chipStyle: const ChipStyle(notchSmoothness: NotchSmoothness.smoothEdge),
      ),
    );
  }

  final List<Widget> _pages = [
    const EntryList(),
    const HomePage(),
    const MyProfilePage(),
  ];
}

////////////////////////////////////////////////

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Habit Tracker',
      home: HabitScreen(),
    );
  }
}

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HabitScreenState createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  List<Habit> habits = [
    Habit(name: 'Exercise', completed: false, date: DateTime.now()),
    Habit(name: 'Read', completed: true, date: DateTime.now()),
    // Add more habits as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: habits.length,
        itemBuilder: (BuildContext context, int index) {
          return HabitCard(habit: habits[index]);
        },
      ),
    );
  }
}

class Habit {
  final String name;
  final bool completed;
  final DateTime date;

  Habit({required this.name, required this.completed, required this.date});
}

class HabitCard extends StatelessWidget {
  final Habit habit;

  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: habit.completed ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            habit.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            habit.completed ? 'Completed' : 'Not Completed',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Date: ${habit.date.year}-${habit.date.month}-${habit.date.day}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
