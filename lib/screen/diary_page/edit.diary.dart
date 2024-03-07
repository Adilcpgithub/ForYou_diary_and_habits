import 'dart:io';

import 'package:flutter/material.dart';
import 'package:for_you/database/dp_f_diary_entry.dart';
import 'package:for_you/models/diary_model.dart';
import 'package:for_you/screen/diary_page/entry_list.dart';
import 'package:for_you/widget/Colors_SnackBar.dart';
import 'package:for_you/widget/textfont_model.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditEntryScreen extends StatefulWidget {
  int index;
  DiaryEntry entry;
  final Function(String title, String content)? editEntry;
  EditEntryScreen(
      {required this.index, required this.entry, this.editEntry, super.key});

  @override
  State<EditEntryScreen> createState() => _EditEntryScreenState();
}

class _EditEntryScreenState extends State<EditEntryScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    _titleController.text = widget.entry.title;
    _contentController.text = widget.entry.content;
    if (widget.entry.imagePath != null) {
      _loadImage(widget.entry.imagePath!);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Entry'),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: 8.0),
              _image != null
                  ? Container(
                      height: 310,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                          image: FileImage(_image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                height: 10,
              ),
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
                decoration: InputDecoration(
                  labelText: 'Content',
                ),
                maxLines: 10,
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () async {
                  if (_titleController.text.isNotEmpty &&
                      _contentController.text.isNotEmpty) {
                    print(' index : ${widget.index}');
                    editEntry_db(
                        widget.index,
                        DiaryEntry(
                          content: _contentController.text,
                          title: _titleController.text,
                          date: widget.entry.date,
                          imagePath: _image != null ? _image!.path : null,
                        ));
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (ctx) {
                      return EntryList();
                    }), (route) => false);
                  } else {
                    showSnackBar(context, 'Invalid Entry', Colors.green);
                  }
                },
                child: Text(
                  'update',
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

  Future<void> _getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  void _loadImage(String imagePath) {
    _image = File(imagePath);
  }
}
