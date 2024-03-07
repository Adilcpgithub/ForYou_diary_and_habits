// ignore: must_be_immutable
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:for_you/models/diary_model.dart';
import 'package:for_you/screen/diary_page/edit.diary.dart';

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
    // TODO: implement initState
    super.initState();
    entry = widget.entry;

    print(" image = ${entry.imagePath}");
    if (entry.imagePath != null) {
      _loadImage(entry.imagePath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diary Entry'),
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
              color: const Color.fromARGB(255, 227, 230, 235),
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
                                '${widget.entry.date.day}/${widget.entry.date.month}/${widget.entry.date.year}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  'Time : ${widget.entry.date.hour}:${widget.entry.date.minute} ')
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
                                style: const TextStyle(
                                  fontSize: 24,
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
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
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
                        style: const TextStyle(fontSize: 18),
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
    print(entry.title);
  });
}
