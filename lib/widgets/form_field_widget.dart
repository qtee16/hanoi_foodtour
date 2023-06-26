import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.readOnly = false,
    this.keyboardType,
  });
  final String title;
  final String hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFD9D9D9),
                width: 0.5,
              ),
            ),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
