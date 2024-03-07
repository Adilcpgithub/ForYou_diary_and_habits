import 'dart:io';
import 'package:flutter/material.dart';
import 'package:for_you/models/diary_model.dart';
import 'package:for_you/widget/Colors_SnackBar.dart';
import 'package:for_you/widget/textfont_model.dart';
import 'package:for_you/database/dp_f_diary_entry.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class AddEntryScreen extends StatefulWidget {
  final Function(String title, String content) addEntry;
  final setEntry;
  const AddEntryScreen(
      {required this.addEntry, required this.setEntry, super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
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
        title: Text('Add New Entry'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(
                Icons.image,
                size: 30,
              ),
              onPressed: () async {
                print('askldjl');
                await _getImage();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                maxLines: 4,
              ),
              SizedBox(height: 5.0),
              _image != null
                  ? Container(
                      width: 200,
                      height: 290,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                          image: FileImage(_image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: _image != null
                    ? Row(
                        children: [
                          GestureDetector(
                            child: Text('Remove Image'),
                            onTap: () => _removeImage(),
                          ),
                          IconButton(
                            onPressed: () {
                              _removeImage();
                            },
                            icon: Icon(Icons.remove_circle_outline_sharp),
                            color: Colors.red,
                          )
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
              TextField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 10,
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _contentController.text.isNotEmpty) {
                    print('setttiii....');

                    addEntry_db(DiaryEntry(
                      title: _titleController.text,
                      content: _contentController.text,
                      imagePath: _image != null ? _image!.path : null,
                      date: DateTime.now(),
                    ));
                    widget.addEntry(
                        _titleController.text, _contentController.text);

                    Navigator.pop(context);
                  } else {
                    showSnackBar(context, 'Invalid Entry', Colors.red);
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: AppColors.modelwhite,
                      fontFamily: Textfonts.MiseryRegular,
                      fontSize: 20),
                ),
                style: TextButton.styleFrom(
                    backgroundColor: AppColors.modelColor1,
                    minimumSize: Size(150, 50)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removeImage() {
    _image = null;
    setState(() {});
  }

  void _openBox() async {
    await Hive.openBox('diary_entries');
  }

  Future<void> _getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }
}
