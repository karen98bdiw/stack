import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:stack/models/logining_models.dart';
import 'package:stack/services/logining_service.dart';
import 'package:stack/utils/contstats.dart';
import 'package:stack/utils/enums.dart';
import 'package:stack/widgets/buttons.dart';
import 'package:stack/widgets/helpers.dart';
import 'package:stack/widgets/inputs.dart';

class SignUpScreen extends StatefulWidget {
  static final routeName = "SignUpScreen";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final UserSignUpModel _userSignUpModel = UserSignUpModel();

  final passwordController = TextEditingController();

  final _formState = GlobalKey<FormState>();

  bool _isLoading = false;

  Future<void> onSignUp() async {
    if (_formState.currentState.validate()) {
      _formState.currentState.save();
      passwordController.clear();

      setState(() {
        _isLoading = true;
      });
      var res = await LoginigService().signUp(model: _userSignUpModel);

      setState(() {
        _isLoading = false;
      });

      //TODO show response in res states;
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: WillPopScope(
        onWillPop: () => willPopForLogginScreens(context),
        child: Scaffold(
            backgroundColor: mainBackgroundColor,
            body: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Center(
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
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
                                  style: TextStyle(
                                      color: lightTextColor, fontSize: 50),
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
      key: _formState,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomFormInput(
                  hintText: "Name",
                  prefix: Icons.person,
                  validator: (v) => v.isEmpty ? "Please write name! " : null,
                  onSaved: (v) => _userSignUpModel.name = v,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: CustomFormInput(
                  hintText: "Surname",
                  prefix: Icons.person,
                  validator: (v) => v.isEmpty ? "Please write surname!" : null,
                  onSaved: (v) => _userSignUpModel.surname = v,
                ),
              ),
            ],
          ),
          CustomFormInput(
            hintText: "Email",
            prefix: Icons.email,
            onSaved: (s) {
              _userSignUpModel.email = s;
            },
            validator: (value) {
              return isValidEmail(value) ? null : "Please write valid E-Mail!";
            },
          ),
          CustomFormInput(
            obscureText: true,
            hintText: "Password",
            prefix: Icons.lock,
            validator: (s) => s.isEmpty
                ? "Please write password!"
                : s.length > 6
                    ? null
                    : "Password should be at last 6 characters",
            onSaved: (s) {
              _userSignUpModel.password = s;
            },
            controller: passwordController,
          ),
          CustomFormInput(
            obscureText: true,
            hintText: "Repeat Passoword",
            prefix: Icons.lock,
            validator: (s) =>
                s == passwordController.text ? null : "Password doesn't match",
          ),
          SizedBox(
            height: 25,
          ),
          CustomFormButton(
            onTap: onSignUp,
            title: "Sign Up",
          ),
          SizedBox(
            height: 13,
          ),
          loginActionChangeText(UserLoginActionChangeType.SingIn, context),
        ],
      ));
}
