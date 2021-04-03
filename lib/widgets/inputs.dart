import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stack/utils/contstats.dart';

class CustomFormInput extends StatelessWidget {
  final String hintText;
  final IconData prefix;

  CustomFormInput({this.hintText, this.prefix});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
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
