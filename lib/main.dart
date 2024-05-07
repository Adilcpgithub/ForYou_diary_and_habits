import 'package:flutter/material.dart';
import 'package:for_you/models/diary_model.dart';
import 'package:for_you/models/habit_model.dart';
import 'package:for_you/models/user_model.dart';
import 'package:for_you/screen/splash_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationCacheDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(DiaryEntryAdapter());
  Hive.registerAdapter(HabitModelAdapter());

  await Hive.openBox<DiaryEntry>('diary_entries');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }
}
