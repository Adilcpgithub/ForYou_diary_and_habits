import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditHabitBottomSheet extends StatefulWidget {
  VoidCallback? onpressed;
  TextEditingController? nameController;
  TextEditingController questionController1;

  EditHabitBottomSheet({
    super.key,
    this.onpressed,
    required this.nameController,
    required this.questionController1,
  });

  @override
  State<EditHabitBottomSheet> createState() => _AddHabbitBottomSheetState();
}

class _AddHabbitBottomSheetState extends State<EditHabitBottomSheet> {
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
                'Edit Habit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: widget.nameController,
                validator: (value) {
                  final trimedValue = value?.trim();
                  if (trimedValue == null || trimedValue.isEmpty) {
                    return 'Please enter a name';
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
                    return 'Please enter a question';
                  }
                  return null;
                },
                controller: widget.questionController1,
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
                      child: const Text('Update habit')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
