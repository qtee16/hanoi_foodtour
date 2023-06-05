import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const CustomTextField(
      {Key? key,
      required this.title,
      required this.hint,
      required this.controller,
      this.isPassword = false,
      this.suffixIcon,
      this.readOnly = false,
      this.textCapitalization = TextCapitalization.sentences,
      this.textInputType,
      this.validator,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.subTitleColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          textCapitalization: textCapitalization,
          keyboardType: textInputType,
          readOnly: readOnly,
          enableSuggestions: !isPassword,
          autocorrect: !isPassword,
          obscureText: isPassword,
          cursorColor: AppColors.blackColor,
          style: const TextStyle(color: AppColors.blackColor, fontSize: 14),
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            fillColor: AppColors.textFieldBackgroundColor,
            labelText: hint,
            labelStyle: const TextStyle(
              color: AppColors.hintTextColor,
            ),
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 0.5,
                color: Color(0xFFB5B5B5),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 0.5,
                color: Color(0xFFB5B5B5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(width: 1, color: AppColors.mainColor),
            ),
          ),
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
