import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextformfeildModel extends StatefulWidget {
  final String hintText;
  final String? errorText;
  final bool obscureText;
  bool? validator;
  final TextInputType? keyboardType;
  final double borderRadius;
  final IconData? icon;
  final TextEditingController? controller;
  final Color color;

  TextformfeildModel(
      {super.key,
      this.obscureText = false,
      this.controller,
      this.keyboardType,
      this.icon,
      this.errorText,
      this.validator,
      required this.hintText,
      required this.borderRadius,
      required this.color});

  @override
  State<TextformfeildModel> createState() => _TextformfeildModelState();
}

class _TextformfeildModelState extends State<TextformfeildModel> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: (value) {
        setState(() {
          widget.validator = value.isEmpty;
        });
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          hintText: widget.hintText,
          errorText: widget.validator! ? widget.errorText : null,
          filled: true,
          fillColor: widget.color,
          prefixIcon: widget.icon != null ? Icon(widget.icon) : null),
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
    );
  }
}
