import 'package:for_you/models/diary_model.dart';
import 'package:hive/hive.dart';

//ValueNotifier<List<DiaryEntry>> _entriesNotifier = ValueNotifier([]);

// ignore: non_constant_identifier_names
Future<void> addEntry_db(DiaryEntry entry) async {
  Box<DiaryEntry> box = await Hive.openBox<DiaryEntry>('diary_entries');

  await box.add(entry);

  await box.close();
}

Future<List<DiaryEntry>> getAllEntries(String userId) async {
  Box<DiaryEntry> box = await Hive.openBox('diary_entries');
  List<DiaryEntry> allEntries =
      box.values.where((entry) => entry.userId == userId).toList();
  await box.close();
  return allEntries;
}

// ignore: non_constant_identifier_names
Future editEntry_db(int index, DiaryEntry diary) async {
  final box = await Hive.openBox<DiaryEntry>('diary_entries');

  await box.put(index, diary);
  await box.close();
}

// ignore: non_constant_identifier_names
Future<void> deleteEntry_db(int entryKey) async {
  Box<DiaryEntry> box = await Hive.openBox<DiaryEntry>('diary_entries');
  await box.delete(entryKey);
}

//
Future<void> deleteAllEntriesss() async {
  final box = await Hive.openBox<DiaryEntry>('diary_entries');

  await box.clear();

  await box.close();
}

Future<List<DiaryEntry>> searchAllEntries(String userId,
    {String? searchQuery}) async {
  Box<DiaryEntry> box = await Hive.openBox('diary_entries');
  List<DiaryEntry> allEntries = box.values.where((entry) {
    if (entry.userId == userId) {
      if (searchQuery != null && searchQuery.isNotEmpty) {
        return entry.title.toLowerCase().contains(searchQuery.toLowerCase());
      } else {
        return true;
      }
    }
    return false;
  }).toList();
  await box.close();
  return allEntries;
}
