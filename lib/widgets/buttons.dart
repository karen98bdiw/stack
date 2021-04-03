import 'package:flutter/material.dart';
import 'package:stack/utils/contstats.dart';

class CustomFormButton extends StatelessWidget {
  final String title;
  final Function onTap;

  CustomFormButton({this.onTap, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 10),
        elevation: 7,
        color: Colors.pink,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        onPressed: onTap,
        child: Text(
          title ?? "",
          style: TextStyle(
            color: lightTextColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final Function onTap;

  CustomButton({this.onTap, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 10),
        elevation: 7,
        color: Colors.pink,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        onPressed: onTap,
        child: Text(
          title ?? "",
          style: TextStyle(
            color: lightTextColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
