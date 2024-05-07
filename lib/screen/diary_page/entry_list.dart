// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:for_you/database/db_user_functions.dart';
import 'package:for_you/database/dp_f_diary_entry.dart';
import 'package:for_you/models/diary_model.dart';
import 'package:for_you/screen/diary_page/add_entry.dart';
import 'package:for_you/screen/diary_page/edit.diary.dart';
import 'package:for_you/screen/diary_page/read_entry.dart';
import 'package:for_you/screen/loginpage.dart';
import 'package:for_you/widget/Colors_SnackBar.dart';
import 'package:for_you/widget/textfont_model.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class EntryList extends StatefulWidget {
  const EntryList({super.key});

  @override
  State<EntryList> createState() => DdState();
}

class DdState extends State<EntryList> {
  List<DiaryEntry> entries = [];
  String currentUserID = '';

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    loadEntries();
    // deleteAllEntriesss();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: GradientAppBar(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 116, 196, 223),
              Color.fromARGB(255, 36, 119, 228)
            ], // Define your gradient colors
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              'My Diary',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'MiseryRegular',
                color: Colors.black,
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 25, right: 25),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Toggle _showSearchField when search button is tapped
                      setState(() {
                        showSearchField = !showSearchField;
                        _searchController.text = '';
                        if (showSearchField == false) {
                          loadEntries();
                        }
                      });
                    },
                    icon: const Icon(
                      size: 30,
                      Icons.search,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Conditional rendering of search field
          showSearchField
              ? Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            TextField(
                              onChanged: (value) async {
                                List<DiaryEntry> entriesFromBox =
                                    await searchAllEntries(currentUserKey!,
                                        searchQuery: value);

                                setState(() {
                                  entries = entriesFromBox;
                                });
                              },
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'SEARCH HERE',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(16.0),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                )
              : const SizedBox
                  .shrink(), // If _showSearchField is false, hide the search field
          // Conditional rendering of data or "no data found" message
          Expanded(
            child: entries.isEmpty // Check if entries list is empty
                ? SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 60),
                          showSearchField
                              ? Column(
                                  children: [
                                    Lottie.asset(
                                      'assets/Animation - 1713593233241.json',
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.fill,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    const SizedBox(
                                      height: 100,
                                    ),
                                    Image.asset(
                                      'assets/images/datanotfound-Photoroom.png-Photoroom.png',
                                      height: 250,
                                      width: 250,
                                    ),
                                  ],
                                ),
                          showSearchField
                              ? const Text(
                                  'Data not found  ',
                                  style: TextStyle(fontSize: 15),
                                )
                              : const Text(
                                  'Write Your Diary',
                                  style: TextStyle(fontSize: 15),
                                ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      final key1 = entries[index].key;
                      // ignore: avoid_print
                      print(key1);
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.horizontal,
                        background: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[500],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            alignment: Alignment.centerLeft,
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        secondaryBackground: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[500],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            alignment: Alignment.centerRight,
                            child: const Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "Confirm",
                                    style: TextStyle(
                                        fontFamily: Textfonts
                                            .ConformityPersonalUseRegular,
                                        color: Colors.red),
                                  ),
                                  content: Text(
                                    "Are you sure you want to delete this entry?",
                                    style: TextStyle(
                                        fontFamily: Textfonts
                                            .ConformityPersonalUseRegular,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        deleteEntry_db(key1);
                                        // Delete the entry
                                        loadEntries();
                                        // Reload the entries from Hive
                                        Navigator.of(context).pop(true);
                                        // Close the confirmation dialog
                                      },
                                      child: const Text(
                                        'Ok',
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          } else if (direction == DismissDirection.endToStart) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
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
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Card(
                                color: Colors.blue[100],
                                child: ListTile(
                                  onLongPress: () {
                                    showSnackBar(
                                        context,
                                        'If you want do delete swipe left to right ',
                                        Colors.green);
                                  },
                                  onTap: () {
                                    gotodiarypage(
                                      context,
                                      entry,
                                      key1,
                                    ).then((value) {
                                      loadEntries();
                                    });
                                  },
                                  title: Text(
                                      entry.title.length > 10
                                          ? entry.title.substring(0, 15)
                                          : entry.title,
                                      style: const TextStyle(fontSize: 19)),
                                  subtitle: Text(
                                    entry.content.length > 20
                                        ? entry.content.substring(0, 20)
                                        : entry.content,
                                  ),
                                  trailing: Column(
                                    children: [
                                      Text(
                                        DateFormat('MMMM dd,yyyy')
                                            .format(entry.date),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: showSearchField
          ? const SizedBox.shrink()
          : Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 36.0, horizontal: 24.0),
              child: FloatingActionButton(
                tooltip: 'Add new entry',
                backgroundColor: const Color.fromARGB(255, 217, 238, 255),
                onPressed: () {
                  loadEntries();

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
                child: Image.asset(
                  'assets/images/add pen icon.png',
                  height: 35,
                ),
              ),
            ),
    );
  }

  void _addEntry(String title, String content) {
    setState(() {
      entries.add(DiaryEntry(
          title: title,
          content: content,
          date: DateTime.now(),
          userId: currentUserKey));
    });
  }

  Future<void> loadEntries() async {
    // ignore: avoid_print
    print('Loading entries');
    if (currentUserKey != null) {
      final List<DiaryEntry> entriesFromBox =
          await getAllEntries(currentUserKey!);
      setState(() {
        entries =
            entriesFromBox; // Assign the list of DiaryEntry objects to entries
      });
      // ignore: avoid_print
      print('Entries loaded');
    } else {
      // ignore: avoid_print
      print('Current user key is null');
    }
  }
}

gotoLoginPage(ctx) {
  Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
    return const LoginPage();
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
  List<DiaryEntry> get_entry = await getAllEntries(currentUserKey!);
  return get_entry;
}

bool showSearchField = false;

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final LinearGradient gradient;
  final Widget title;
  final List<Widget> actions;
  final bool centerTitle;

  const GradientAppBar({
    super.key,
    required this.gradient,
    required this.title,
    required this.actions,
    required this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: AppBar(
        backgroundColor: Colors.transparent,
        title: title,
        centerTitle: centerTitle,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
