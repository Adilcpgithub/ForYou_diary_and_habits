import 'dart:io';
import 'package:flutter/material.dart';
import 'package:for_you/database/db_user_functions.dart';
import 'package:for_you/models/diary_model.dart';
import 'package:for_you/screen/diary_page/entry_list.dart';
import 'package:for_you/widget/Colors_SnackBar.dart';
import 'package:for_you/widget/textfont_model.dart';
import 'package:for_you/database/dp_f_diary_entry.dart';

import 'package:image_picker/image_picker.dart';

class AddEntryScreen extends StatefulWidget {
  final Function(String title, String content) addEntry;
  // ignore: prefer_typing_uninitialized_variables
  final setEntry;
  const AddEntryScreen(
      {required this.addEntry, required this.setEntry, super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  DateTime _selectedDate = DateTime.now();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Entry',
          style: TextStyle(
            fontFamily: Textfonts.ConformityPersonalUseRegular,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(
                Icons.image,
                size: 30,
              ),
              onPressed: () async {
                await _getImage();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ////////////////////////////////////////////////////////////////////////////////////////////////
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          _selectDate();
                        },
                        child: const Text(
                          'Choose Date',
                          style: TextStyle(color: Colors.black),
                        )),
                    GestureDetector(
                      onTap: () {
                        _selectDate();
                      },
                      child: Text(
                        'Date: ${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              ////////////////////////////////////////////////////////////////////////////////////////////////
              TextField(
                style: const TextStyle(fontSize: 26.0), // Set text size to 16
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ), // Border decoration

                  contentPadding: const EdgeInsets.all(
                      16.0), // Padding inside the TextField
                  fillColor: Colors.grey[200], // Background color
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              _image != null
                  ? GestureDetector(
                      onTap: () async {
                        await _getImage();
                      },
                      child: Container(
                        width: 200,
                        height: 290,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: _image != null
                    ? Row(
                        children: [
                          GestureDetector(
                            child: const Text('Remove Image'),
                            onTap: () => _removeImage(),
                          ),
                          IconButton(
                            onPressed: () {
                              _removeImage();
                            },
                            icon: const Icon(Icons.remove_circle_outline_sharp),
                            color: Colors.red,
                          )
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
              TextField(
                style: const TextStyle(fontSize: 20.0), // Set text size to 16
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ), // Border decoration

                  contentPadding: const EdgeInsets.all(
                      16.0), // Padding inside the TextField
                  fillColor: Colors.grey[200], // Background color
                ),
                maxLines: 10,
              ),
              const SizedBox(height: 16.0),

              TextButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _contentController.text.isNotEmpty) {
                    addEntry_db(DiaryEntry(
                        title: _titleController.text,
                        content: _contentController.text,
                        // ignore: prefer_null_aware_operators
                        imagePath: _image != null ? _image!.path : null,
                        date: _selectedDate,
                        userId: currentUserKey));
                    widget.addEntry(
                        _titleController.text, _contentController.text);

                    Navigator.pop(context);
                  } else {
                    showSnackBar(context, 'Invalid Entry', Colors.red);
                  }
                  showSearchField = false;
                },
                style: TextButton.styleFrom(
                    backgroundColor: AppColors.modelColor1,
                    minimumSize: const Size(150, 50)),
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: AppColors.modelwhite,
                      fontFamily: Textfonts.MiseryRegular,
                      fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    // Calculate initial date as yesterday
    final DateTime initialDate =
        DateTime.now().subtract(const Duration(days: 1));

    // Show date picker dialog with restricted date range
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900), // Restrict to a very old date
      lastDate: initialDate, // Restrict to yesterday's date
    );

    // Update selected date if a date is picked
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _removeImage() {
    _image = null;
    setState(() {});
  }

  Future<void> _getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }
}
