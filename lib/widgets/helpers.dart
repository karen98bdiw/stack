import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stack/pages/login_register_screens/sign_in_screen.dart';
import 'package:stack/pages/login_register_screens/sign_up_screen.dart';
import 'package:stack/services/profile_services.dart';
import 'package:stack/utils/contstats.dart';
import 'package:stack/utils/enums.dart';
import 'package:stack/widgets/buttons.dart';

bool isValidEmail(String email) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

Widget loginActionChangeText(
    UserLoginActionChangeType type, BuildContext context) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
            text: type == UserLoginActionChangeType.SingIn
                ? "Already have Account?  "
                : "Not Registred Yet?  "),
        TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              print("on tap called");
              type == UserLoginActionChangeType.SignUp
                  ? Navigator.of(context)
                      .pushReplacementNamed(SignUpScreen.routeName)
                  : Navigator.of(context).pushNamed(SignInScreen.routeName);
            },
          text:
              type == UserLoginActionChangeType.SingIn ? "Sign In" : "Sing Up",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.pink,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}

Future<bool> exitFromAppConfirmation(BuildContext context) async {
  var res = await showDialog(
    context: context,
    builder: (c) => Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Looks like you want to exit app?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: "No",
                      onTap: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomButton(
                      title: "Yes",
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );

  return res ?? false;
}

Future<bool> confirmLogOut({BuildContext context}) async {
  var res = await showDialog(
    context: context,
    builder: (c) => Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Looks like you want to log out?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: "No",
                      onTap: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomButton(
                      title: "Yes",
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );

  return res ?? false;
}

Future<bool> willPopForHome({BuildContext context}) async {
  var res = await confirmLogOut(context: context);

  return res ?? false;
}

Future<bool> willPopForLogginScreens(context) async {
  var res = await exitFromAppConfirmation(context);
  if (res) {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }
  return res ?? false;
}

void showError(msg) {
  Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: mainButtonColor,
    fontSize: 16,
    textColor: Colors.white,
  );
}
