import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:stack/utils/contstats.dart';
import 'package:stack/utils/enums.dart';
import 'package:stack/widgets/buttons.dart';
import 'package:stack/widgets/helpers.dart';
import 'package:stack/widgets/inputs.dart';

class SignUpScreen extends StatelessWidget {
  static final routeName = "SignUpScreen";

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
                            style:
                                TextStyle(color: lightTextColor, fontSize: 50),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          form(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget form(BuildContext context) => Form(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomFormInput(
                  hintText: "Name",
                  prefix: Icons.person,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: CustomFormInput(
                  hintText: "Surname",
                  prefix: Icons.person,
                ),
              ),
            ],
          ),
          CustomFormInput(
            hintText: "Email",
            prefix: Icons.email,
          ),
          CustomFormInput(
            hintText: "Password",
            prefix: Icons.lock,
          ),
          CustomFormInput(
            hintText: "Repeat Passoword",
            prefix: Icons.lock,
          ),
          SizedBox(
            height: 25,
          ),
          CustomFormButton(
            onTap: () {},
            title: "Sign Up",
          ),
          SizedBox(
            height: 13,
          ),
          loginActionChangeText(UserLoginActionChangeType.SingIn, context),
        ],
      ));
}
