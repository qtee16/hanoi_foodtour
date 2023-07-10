import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.textInputType,
    this.validator,
    this.onChanged,
  }) : super(key: key);
  
  final String title;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
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
          textCapitalization: widget.textCapitalization,
          keyboardType: widget.textInputType,
          readOnly: widget.readOnly,
          enableSuggestions: !widget.isPassword,
          autocorrect: !widget.isPassword,
          obscureText: widget.isPassword ? !isShow : false,
          cursorColor: AppColors.blackColor,
          style: const TextStyle(color: AppColors.blackColor, fontSize: 14),
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: widget.isPassword
              ? InkWell(
                onTap: () {
                  setState(() {
                    isShow = !isShow;
                  });
                },
                child: Icon(
                  isShow ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.greyText,
                ),
              )
              : null,
            fillColor: AppColors.textFieldBackgroundColor,
            labelText: widget.hint,
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
          validator: widget.validator,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}