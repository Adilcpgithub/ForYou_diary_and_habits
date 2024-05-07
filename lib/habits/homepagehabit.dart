import 'package:flutter/material.dart';
import 'package:for_you/database/db_user_functions.dart';
import 'package:for_you/database/habit_db.dart';
import 'package:for_you/habits/add_floatingbutton.dart';
import 'package:for_you/habits/addhabbi.dart';
import 'package:for_you/habits/edit.habit.dart';
import 'package:for_you/habits/habit.checkbox.dart';
import 'package:for_you/habits/habit_name.dart';
import 'package:for_you/models/habit_model.dart';
import 'package:for_you/screen/button_bar/button_bar_home.dart';
import 'package:for_you/widget/Colors_SnackBar.dart';
import 'package:for_you/widget/textfont_model.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController habbitNameController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController editHabbitNameController =
      TextEditingController();
  final TextEditingController editQuestionController = TextEditingController();
  // ignore: non_constant_identifier_names
  HabitDBFunctions habit_db = HabitDBFunctions();
  bool editMode = false;
  List<DateTime> dateList = [];
  List<HabitModel> habits = [];
  @override
  void initState() {
    // habbitNotifierList.value.clear();
    super.initState();
    getdates(DateTime.now().subtract(const Duration(days: 30)));

    habit_db.getHabbit().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: GradientAppBar(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 116, 196, 223),
                Color.fromARGB(255, 36, 119, 228)
              ], // Define your gradient colors
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                'track your habit',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: Textfonts.MiseryRegular,
                  color: const Color.fromARGB(255, 0, 0, 0),
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
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        editMode = !editMode;

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: SizedBox(
                                width: 350,
                                height: editMode ? 300 : 220,
                                child: AlertDialog(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  contentPadding: const EdgeInsets.all(
                                      10), // Adjust the padding as needed
                                  content: Center(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: editMode
                                              ? Text(
                                                  'Edit Mode On',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                      color: Colors.red[600]),
                                                )
                                              : Text(
                                                  'Edit Mode off',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                      color: Colors.red[600]),
                                                ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        editMode
                                            ? const Text(
                                                'long press on your  habit data\n  you can delete your habit \nor double press you can edit ')
                                            : const SizedBox(
                                                height: 0,
                                                width: 0,
                                              ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),

                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Close',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: habbitNotifierList.value.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 120,
                          ),
                          Image.asset(
                            'assets/images/datanotfound-Photoroom.png-Photoroom.png',
                            height: 250,
                            width: 250,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Add habbits'),
                        ],
                      ),
                    )
                  : ValueListenableBuilder(
                      valueListenable: habbitNotifierList,
                      builder: (BuildContext context, List<HabitModel> value,
                          Widget? child) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 160,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 36),
                                child: ListView.builder(
                                    itemCount: value.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onDoubleTap: () {
                                          if (editMode) {
                                            editQuestionController.text =
                                                value[index].habbitQuestion ??
                                                    '';
                                            editHabbitNameController.text =
                                                value[index].habbitName;

                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          EditHabitBottomSheet(
                                                            questionController1:
                                                                editQuestionController,
                                                            nameController:
                                                                editHabbitNameController,
                                                            onpressed:
                                                                () async {
                                                              if (habbitNameController
                                                                  .text
                                                                  .isNotEmpty) {
                                                              } else {
                                                                await habit_db.editHabbit(
                                                                    value[index]
                                                                        .key,
                                                                    HabitModel(
                                                                        habbitName:
                                                                            editHabbitNameController
                                                                                .text,
                                                                        habbitQuestion:
                                                                            editQuestionController.text));
                                                              }
                                                              // ignore: await_only_futures
                                                              await habit_db
                                                                  .getHabbit;

                                                              setState(() {});
                                                              // ignore: use_build_context_synchronously
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          } else {
                                            showSnackBar(
                                                context,
                                                ' If you wante to edit or delete. turn on edit mode ',
                                                Colors.green);
                                          }
                                        },
                                        onLongPress: () async {
                                          if (editMode) {
                                            // ignore: avoid_print
                                            print(
                                                'this the current key ${value[index].key}');
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 350,
                                                    height: 250,
                                                    child: AlertDialog(
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              248,
                                                              248,
                                                              248),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              10), // Adjust the padding as needed
                                                      content: Center(
                                                          // ignore: avoid_unnecessary_containers
                                                          child: Container(
                                                        child: const Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 10),
                                                              child: Text(
                                                                'Deleting habit',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      )),

                                                      actions: <Widget>[
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Cancel')),
                                                        TextButton(
                                                          onPressed: () async {
                                                            int key =
                                                                value[index]
                                                                    .key;
                                                            await habit_db
                                                                .deleteHabbit(
                                                                    key);

                                                            // ignore: await_only_futures
                                                            await habit_db
                                                                .getHabbit;

                                                            setState(() {
                                                              habits.removeWhere(
                                                                  (habit) =>
                                                                      habit
                                                                          .key ==
                                                                      key);
                                                            });

                                                            // ignore: use_build_context_synchronously
                                                            Navigator.of(
                                                                    context)
                                                                .pushAndRemoveUntil(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (ctx) {
                                                              return MyHomePage(
                                                                selectedIndex:
                                                                    1,
                                                              );
                                                            }),
                                                                    (route) =>
                                                                        false);
                                                          },
                                                          child: const Text(
                                                            'Ok',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            showSnackBar(
                                                context,
                                                ' If you want to delete or edit. touch the edit button ',
                                                Colors.green);
                                          }
                                          /////
                                        },
                                        child: HabbitTile(
                                          habbitName: value[index].habbitName,
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: dateList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                          ),
                                          child: Text(DateFormat('E')
                                              .format(dateList[index])),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text('${dateList[index].day}'),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        ...value.map((e) => CheckBox(
                                            initialValue: e.habbitCompleted?[
                                                    dateList[index]] ??
                                                false,
                                            onChanged: (isChecked) {
                                              HabitDBFunctions()
                                                  .updateCompletion(
                                                      dateList[index],
                                                      isChecked ?? false,
                                                      e.habbitName);
                                            })),
                                        if (index != dateList.length - 1)
                                          const Divider(),
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
        floatingActionButton: AddButton(
          onpressed: () {
            showModalBottomSheet(
                backgroundColor: const Color.fromARGB(255, 182, 219, 248),
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AddHabbitBottomSheet(
                            nameControllerAdd: habbitNameController,
                            questionControllerAdd: questionController,
                            onpressed: () async {
                              if (habbitNameController.text.isEmpty) {
                              } else {
                                if (habbitNotifierList.value.length < 14) {
                                  await habit_db.addHabbit(HabitModel(
                                      habbitName: habbitNameController.text,
                                      habbitQuestion: questionController.text,
                                      userId: currentUserKey));
                                  await habit_db.getHabbit();
                                  questionController.text = '';
                                  habbitNameController.text = '';
                                  setState(() {});
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                } else {
                                  Navigator.pop(context);
                                  questionController.text = '';
                                  habbitNameController.text = '';
                                  showSnackBar(context,
                                      'Only you can add 14 habits', Colors.red);
                                }
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ));
  }

  getdates(DateTime startDate) {
    for (DateTime date = DateTime.now();
        date.isAfter(startDate);
        date = date.subtract(const Duration(days: 1))) {
      dateList.add(DateTime(date.year, date.month, date.day, 0, 0, 0));
    }
  }

  Future<void> updateCheckBoxData() async {
    // Fetch the latest list of habits
    List<HabitModel> updatedHabits = habit_db.getHabbit() as List<HabitModel>;
    setState(() {
      habits = updatedHabits;
    });
  }
}

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
