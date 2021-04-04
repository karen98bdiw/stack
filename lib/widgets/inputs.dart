import 'package:flutter/material.dart';
import 'package:stack/utils/contstats.dart';

class CustomFormInput extends StatelessWidget {
  final String hintText;
  final IconData prefix;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final bool obscureText;

  CustomFormInput({
    this.hintText,
    this.prefix,
    this.onSaved,
    this.validator,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        onSaved: onSaved,
        validator: validator,
        style: TextStyle(color: lightTextColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: lightTextColor, height: 1),
          prefixIcon: prefix != null
              ? Icon(
                  prefix,
                  size: 22,
                )
              : null,
        ),
      ),
    );
  }
}
