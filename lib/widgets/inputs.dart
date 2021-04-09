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

Widget customInput(
  String hint,
  TextEditingController controller,
  bool obscure,
  FormFieldSetter<String> onSaved,
  FormFieldValidator<String> validator,
) {
  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: TextFormField(
      validator: validator,
      onSaved: onSaved,
      cursorColor: Colors.white,
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      obscureText: obscure,
      style: TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        focusColor: Colors.white,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(
            fontWeight: FontWeight.w300, fontSize: 18, color: Colors.white),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0))),
      ),
    ),
  );
}
