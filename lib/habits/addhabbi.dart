import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddHabbitBottomSheet extends StatefulWidget {
  VoidCallback? onpressed;
  TextEditingController? nameControllerAdd;
  TextEditingController questionControllerAdd;

  AddHabbitBottomSheet({
    super.key,
    this.onpressed,
    this.nameControllerAdd,
    required this.questionControllerAdd,
  });

  @override
  State<AddHabbitBottomSheet> createState() => _AddHabbitBottomSheetState();
}

class _AddHabbitBottomSheetState extends State<AddHabbitBottomSheet> {
  String? selectedItem;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: formKey,
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Habbit',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: widget.nameControllerAdd,
                validator: (value) {
                  final trimedValue = value?.trim();
                  if (trimedValue == null || trimedValue.isEmpty) {
                    return 'Please enter valid a name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'e.g.Excercise',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  final trimedValue = value?.trim();
                  if (trimedValue == null || trimedValue.isEmpty) {
                    return 'Please enter valid question';
                  }
                  return null;
                },
                controller: widget.questionControllerAdd,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Question',
                    hintText: 'e.g.Did you do Excercise today?'),
              ),
              const SizedBox(
                height: 8,
              ),

              const SizedBox(
                height: 23,
              ),
              // ignore: prefer_const_constructors
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.onpressed!();
                        }
                      },
                      child: const Text(
                        'Create habbit',
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
