import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:stack/utils/contstats.dart';
import 'package:stack/utils/enums.dart';
import 'package:stack/widgets/buttons.dart';
import 'package:stack/widgets/helpers.dart';
import 'package:stack/widgets/inputs.dart';

class SignInScreen extends StatelessWidget {
  static final routeName = "SignInScreen";

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: WillPopScope(
        onWillPop: () => willPopForLogginScreens(context),
        child: Scaffold(
          backgroundColor: mainBackgroundColor,
          body: SafeArea(
            child: Center(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (o) {
                  o.disallowGlow();
                  return false;
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: scaffoldPadding,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Stack",
                          style: TextStyle(color: lightTextColor, fontSize: 50),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomFormInput(
                          hintText: "Email",
                          prefix: Icons.email,
                        ),
                        CustomFormInput(
                          hintText: "Password",
                          prefix: Icons.lock,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomFormButton(
                          onTap: () {},
                          title: "Sign In",
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        loginActionChangeText(
                            UserLoginActionChangeType.SignUp, context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
