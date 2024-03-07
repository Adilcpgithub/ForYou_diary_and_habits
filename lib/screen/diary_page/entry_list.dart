import 'dart:math';

import 'package:flutter/material.dart';
import 'package:for_you/database/db_functions.dart';
import 'package:for_you/database/dp_f_diary_entry.dart';
import 'package:for_you/models/diary_model.dart';
import 'package:for_you/screen/diary_page/add_entry.dart';
import 'package:for_you/screen/diary_page/edit.diary.dart';
import 'package:for_you/screen/diary_page/read_entry.dart';
import 'package:for_you/screen/loginpage.dart';
import 'package:hive/hive.dart';

class EntryList extends StatefulWidget {
  const EntryList({super.key});

  @override
  State<EntryList> createState() => DdState();
}

class DdState extends State<EntryList> {
  List<DiaryEntry> entries = [];
  String currentUserID = '';

  void initState() {
    print('welcome');

    loadEntries();
    // deleteAllEntriesss();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Diary'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await setCheckLogin(false);
              gotoLoginPage(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          final key1 = entries[index].key;
          print(key1);
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            background: Container(
              decoration: BoxDecoration(
                color: Colors.red[500],
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 40),
              alignment: Alignment.centerLeft,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              decoration: BoxDecoration(
                color: Colors.blue[500],
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 40),
              alignment: Alignment.centerRight,
              child: Icon(Icons.edit, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Confirm"),
                      content:
                          Text("Are you sure you want to delete this entry?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('Cancel')),
                        TextButton(
                          onPressed: () async {
                            try {
                              deleteEntry_db(key1); // Delete the entry
                              loadEntries(); // Reload the entries from Hive
                              Navigator.of(context)
                                  .pop(true); // Close the confirmation dialog
                            } catch (e) {
                              print('Error deleting entry: $e');
                              // Handle the error as needed (e.g., show a dialog)
                            }
                          },
                          child: Text('Ok'),
                        )
                      ],
                    );
                  },
                );
              } else if (direction == DismissDirection.endToStart) {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return EditEntryScreen(
                    index: entries[index].key,
                    entry: entry,
                  );
                })).then((value) async {
                  await loadEntries();
                });
              }
              return false;
            },
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {}
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    gotodiarypage(
                      context,
                      entry,
                      key1,
                    ).then((value) {
                      loadEntries();
                    });
                    print('gel');
                  },
                  title: Text(entry.title),
                  subtitle: Text(
                    entry.content.length > 10
                        ? entry.content.substring(0, 10)
                        : entry.content,
                  ),
                  trailing: Column(
                    children: [
                      Text(
                        '${entry.date.day}/${entry.date.month}/${entry.date.year}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEntryScreen(
                      addEntry: (title, content) {
                        _addEntry(title, content);
                      },
                      setEntry: null,
                    )),
          ).then((value) {
            loadEntries();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addEntry(String title, String content) {
    setState(() {
      entries.add(DiaryEntry(
        title: title,
        content: content,
        date: DateTime.now(),
      ));
    });
  }

  Future<void> deleteEntry(my_key) async {
    var box = await Hive.openBox('diary_entries');
    await box.delete(my_key);
    await box.close();
    getAllEntries();
  }

  void _editOneEntry(int index, String title, String content) {
    setState(() {
      entries[index] = DiaryEntry(
        title: title,
        content: content,
        date: DateTime.now(),
      );
    });
  }

  Future loadEntries() async {
    print('object');
    final box = await Hive.openBox<DiaryEntry>('diary_entries');
    print('object');

    setState(() {
      entries = box.values.toList();
      // Get all entries from the box
    });
    await box.close();
  }
}

gotoLoginPage(ctx) {
  Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
    return LoginPage();
    ////chane page route name/////
  }), (route) => false);
}

Future gotodiarypage(ctx, entry, key1) async {
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (ctx) {
        return ReadDiaryPage(
          index: key1,
          entry: entry,
        );
      },
    ),
  );
}

Future<List<DiaryEntry>> getdatafrom_db() async {
  List<DiaryEntry> get_entry = await getAllEntries();
  return get_entry;
}
