// ignore: must_be_immutable
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:for_you/models/diary_model.dart';
import 'package:for_you/screen/diary_page/edit.diary.dart';
import 'package:for_you/widget/textfont_model.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ReadDiaryPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  DiaryEntry entry;
  // ignore: prefer_typing_uninitialized_variables
  var index;

  ReadDiaryPage({
    required this.entry,
    required this.index,
    super.key,
  });

  @override
  State<ReadDiaryPage> createState() => _ReadDiaryPageState();
}

class _ReadDiaryPageState extends State<ReadDiaryPage> {
  late DiaryEntry entry;
  File? _image;
  @override
  void initState() {
    super.initState();
    entry = widget.entry;

    if (entry.imagePath != null) {
      _loadImage(entry.imagePath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Diary Entry',
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
                Icons.edit_note_outlined,
                size: 40,
              ),
              onPressed: () {
                //gotoEditPage(ctx, entry, index, editEntry);
                gotoEditPage(context, widget.entry, widget.index).then((value) {
                  setState(() {
                    entry = value;
                    if (entry.imagePath != null) {
                      _loadImage(entry.imagePath!); // Load image if changed
                    }
                  });
                });
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Card(
              color: Colors.blue[50],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              Text(
                                DateFormat('MMMM dd,yyyy').format(entry.date),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                widget.entry.title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: Textfonts.MiseryRegular,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _image != null
                        ? Center(
                            child: Container(
                              width: 350,
                              height: 250,
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
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        widget.entry.content,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loadImage(String imagePath) {
    _image = File(imagePath);
  }
}

Future gotoEditPage(ctx, DiaryEntry entry, index) async {
  await Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (ctx) {
        //index, entry.title, entry.content,
        return EditEntryScreen(
          index: index,
          entry: entry,
        );
      },
    ),
  ).then((value) {
    entry = value;
  });
}
