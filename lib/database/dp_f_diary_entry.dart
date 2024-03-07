//import 'package:flutter/material.dart';
import 'package:for_you/models/diary_model.dart';
import 'package:hive/hive.dart';

//ValueNotifier<List<DiaryEntry>> _entriesNotifier = ValueNotifier([]);

Future<void> addEntry_db(DiaryEntry entry) async {
  print('Adding new entry: ${entry.title}');
  Box<DiaryEntry> box = await Hive.openBox<DiaryEntry>('diary_entries');
  // await box.compact(); // Re-index the keys
  final key = await box.add(entry);
  print('aaaaa');
  print(entry.title);
  print(entry.content);
  print(entry.date);
  print(entry.imagePath);
  print('aaaaa');
  await box.close();

  print('Added entry with key: $key');
  print('Entry added successfully!');
}

Future<List<DiaryEntry>> getAllEntries() async {
  print('working');
  Box<DiaryEntry> box = await Hive.openBox('diary_entries');
  List<DiaryEntry> allEntries = box.values.toList();
  await box.close();
  return allEntries;
}

Future editEntry_db(int index, DiaryEntry diary) async {
  final box = await Hive.openBox<DiaryEntry>('diary_entries');
  print(diary.title);
  print(diary.content);
  print(diary.date);
  await box.put(index, diary);
  await box.close();
}

Future<void> deleteEntry_db(int entryKey) async {
  print('Deleting entry with key: $entryKey');
  Box<DiaryEntry> box = await Hive.openBox<DiaryEntry>('diary_entries');
  await box.delete(entryKey);
  print('Entry deleted successfully!');
  print('Remaining keys:');
  for (var key in box.keys) {
    print('Key: $key');
  }
}

//
Future<void> deleteAllEntriesss() async {
  print('Deleting all entries...');
  final box = await Hive.openBox<DiaryEntry>('diary_entries');
  try {
    await box.clear();
    print('All entries deleted successfully!');
  } catch (e) {
    print('Error deleting entries: $e');
  }
  await box.close();
}
