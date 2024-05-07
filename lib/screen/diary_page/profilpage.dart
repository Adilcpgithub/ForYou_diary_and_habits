// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import "package:for_you/database/db_user_functions.dart";
import 'package:for_you/database/habit_db.dart';
import 'package:for_you/models/user_model.dart';
import 'package:for_you/screen/diary_page/entry_list.dart';
import 'package:for_you/screen/diary_page/privacypolicy.dart';
import 'package:for_you/screen/diary_page/tems_condition.dart';
import 'package:for_you/widget/Colors_SnackBar.dart';
import 'package:for_you/widget/textfont_model.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  File? _image;
  User? currentUser;
  String? _username;
  bool editBool = false;
  TextEditingController newUserCountroller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    retrieveCurrentUser().then((user) {
      if (user != null) {
        setState(() {
          _username = user.name;
          newUserCountroller.text = user.name;
        });
      }
    }).catchError((error) {
      //  print('Error retrieving current user: $error');
    });

    ////////////////////////////////
    getImage().then((imagePath) {
      if (imagePath != null) {
        setState(() {
          _image = File(imagePath); // Convert image path to File object
        });
      }
    }).catchError((error) {
      // print('Error retrieving image data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/4.png',
                  fit: BoxFit.fill,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 62,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  editBool = true;
                                });

                                _showBottomSheet();
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 20,
                              )),
                          IconButton(
                            icon: const Icon(
                              Icons.logout,
                              size: 20,
                            ),
                            onPressed: () async {
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
                                      "Are you sure you want to sign out?",
                                      style: TextStyle(
                                          fontFamily: Textfonts
                                              .ConformityPersonalUseRegular,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0)),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                          )),
                                      TextButton(
                                        onPressed: () async {
                                          await setCheckLogin(false);
                                          habbitNotifierList.value.clear;
                                          // ignore: use_build_context_synchronously
                                          gotoLoginPage(context);
                                        },
                                        child: const Text(
                                          'Sign out',
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                showMenu<String>(
                                  color: Colors.black,
                                  context: context,
                                  position: RelativeRect.fromLTRB(
                                      MediaQuery.of(context).size.width - 48,
                                      kToolbarHeight,
                                      0,
                                      0), // Positioning menu to the right of the icon
                                  items: [
                                    PopupMenuItem<String>(
                                      value: 'item1',
                                      child: GestureDetector(
                                        onTap: () {
                                          gotoprivatPolicyPage();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              gotoprivatPolicyPage();
                                            },
                                            child: const Text(
                                              'Privacy Policy',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'item2',
                                      child: GestureDetector(
                                        onTap: () {
                                          gotoprivatPolicyPage();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              gotoTermsAndCondition();
                                            },
                                            child: const Text(
                                              'Terms and Condition',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              icon: const Icon(Icons.more_vert_outlined)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 121,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 9,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: _image != null
                                    ? FileImage(_image!)
                                    : const AssetImage(
                                            'assets/images/profilesample.png')
                                        as ImageProvider<Object>,
                              ),
                            ),
                            editBool
                                ? Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add_a_photo,
                                            size: 30,
                                            color: Colors.blueGrey,
                                          ),
                                          onPressed: () async {
                                            editBool = false;

                                            await _getImage();
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink()
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    _username != null
                        ? Text(
                            '$_username',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: Textfonts.MiseryRegular,
                            ),
                          )
                        : const Text(
                            '',
                          ),
                    const SizedBox(
                      height: 190,
                    ),
                    const Text(
                      'Version 1.0.0',
                      style: TextStyle(
                          color: Color.fromARGB(94, 0, 0, 0), fontSize: 18),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() async {
    showModalBottomSheet(
      backgroundColor: Colors.blue[100],
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  ' Username And Image',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: newUserCountroller,
                  //  initialValue: _username,
                  decoration: const InputDecoration(
                    labelText: ' Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.modelColor1,
                      ),
                      onPressed: () async {
                        await editUserName(newUserCountroller.text);
                        setState(() {
                          _username = newUserCountroller.text;
                        });
                        editBool = false;
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontFamily: Textfonts.MiseryRegular,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: const Color.fromARGB(90, 0, 0, 0),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : const AssetImage('assets/images/profilesample.png')
                              as ImageProvider<Object>,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.modelColor1,
                      ),
                      onPressed: () async {
                        setState(() {
                          _removeImage();
                        });
                        Navigator.pop(context);
                        editBool = false;
                      },
                      child: Text(
                        'Remove',
                        style: TextStyle(
                          fontFamily: Textfonts.MiseryRegular,
                          color: Colors.red[200],
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.modelColor1,
                      ),
                      onPressed: () async {
                        await editUserName(newUserCountroller.text);
                        setState(() {
                          _username = newUserCountroller.text;
                        });

                        editBool = false;

                        await _getImage();
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Pick',
                        style: TextStyle(
                          fontFamily: Textfonts.MiseryRegular,
                          color: Colors.red[200],
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _removeImage() async {
    _image = null;
    // Remove the image data from the database
    final userBox = await Hive.openBox<User>('users');
    final User? user = userBox.get(int.parse(currentUserKey!));
    if (user != null) {
      user.imageData = null; // Set image data to null to remove it
      userBox.put(int.parse(currentUserKey!), user);
    }
  }

  Future<void> _getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      setImage(_image!.path); // Pass the file path instead of file object
    }
  }

  getUser() async {
    currentUser = await retrieveCurrentUser();
  }

  gotoprivatPolicyPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return const PrivatPolicy();
    }));
  }

  gotoTermsAndCondition() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return const TermsAndConditionsScreen();
    }));
  }
}
