import 'package:flutter/material.dart';

class CustomerTextForm extends StatelessWidget {
  const CustomerTextForm({
    super.key,
    required this.controller,
    required this.message,
    required this.formKey,
    required this.icon,
    required this.hintText,
    this.onEditingComplete,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.textInputType = TextInputType.text,
    this.isEmail = false,
  });

  final TextEditingController controller;
  final Key formKey;

  final String message;
  final Widget icon;

  final String hintText;

  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;

  final bool obscureText;
  final TextInputType textInputType;
  final bool isEmail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        key: formKey,
        child: TextFormField(
          onTapOutside: (PointerDownEvent event) =>
              FocusScope.of(context).unfocus(),
          obscureText: obscureText,
          keyboardType: textInputType,
          controller: controller,
          decoration: InputDecoration(
            icon: icon,
            contentPadding: const EdgeInsets.all(10),
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              color: Colors.black45,
              fontWeight: FontWeight.w400,
            ),
            fillColor: const Color(0xFFF9FAFA),
            border: buildBorder(),
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return message;
            }
            if (isEmail) {
              final emailRegex = RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              );
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
            }
            if (value.length < 5) {
              return 'Must be at least 5 characters long';
            }
            return null;
          },
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: (value) {
            // Close the keyboard on submission
            FocusScope.of(context).unfocus();
            if (onFieldSubmitted != null) {
              onFieldSubmitted!(value);
            }
          },
        ),
      ),
    );
  }
}

OutlineInputBorder buildBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: const BorderSide(
      width: 1,
      color: Colors.grey,
    ),
  );
}
