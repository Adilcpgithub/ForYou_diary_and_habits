//floating action button
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class AddButton extends StatelessWidget {
  VoidCallback? onpressed;
  AddButton({
    super.key,
    this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 24.0),
      child: FloatingActionButton(
        onPressed: onpressed,
        backgroundColor: const Color.fromARGB(255, 221, 240, 243),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Lottie.asset(
          'assets/Animation - 1713588450811.json',
          width: 50,
          height: 50,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
