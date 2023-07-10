import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/constants.dart';

class InfoTextField extends StatelessWidget {
  const InfoTextField({
    super.key,
    required this.title,
    required this.content,
    this.suffixIcon,
  });
  final String title;
  final String content;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: AppColors.greyTitle,
          ),
        ),
        const SizedBox(height: 6,),
        TextFormField(
          style: const TextStyle(fontSize: 16),
          initialValue: content,
          readOnly: true,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD9D9D9))
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD9D9D9))
            ),
          ),
        ),
      ],
    );
  }
}