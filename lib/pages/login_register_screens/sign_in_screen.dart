import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:stack/models/logining_models.dart';
import 'package:stack/models/user.dart';
import 'package:stack/pages/home_screen_buisnes.dart';
import 'package:stack/pages/home_screen_user.dart';
import 'package:stack/pages/profile_screean.dart';
import 'package:stack/services/logining_service.dart';
import 'package:stack/services/profile_services.dart';
import 'package:stack/utils/contstats.dart';
import 'package:stack/utils/enums.dart';
import 'package:stack/widgets/buttons.dart';
import 'package:stack/widgets/helpers.dart';
import 'package:stack/widgets/inputs.dart';

class SignInScreen extends StatefulWidget {
  static final routeName = "SignInScreen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formState = GlobalKey<FormState>();

  ProfileServices profileServices;

  bool _isLoadig = false;

  final _userSignInModel = UserSingInModel();

  void onSignIn() async {
    if (_formState.currentState.validate()) {
      _formState.currentState.save();

      setState(() {
        _isLoadig = true;
      });

      var res = await LoginigService().singIn(model: _userSignInModel);

      if (res.state == SingInState.Succses) {
        // profileServices.user.state = CurentUserState.Signed;
        profileServices.user.id =
            res.id; //TODO maybe take this line to service...
        await ProfileServices().getProfile();
        await ProfileServices().getUserCompany();

        if (profileServices.user.type == UserType.Buisnes) {
          Navigator.of(context).pushNamed(ProfilePage.routeName);
        } else {
          Navigator.of(context).pushNamed(HomeScreenUser.routeName);
        }
      }

      setState(() {
        _isLoadig = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    profileServices = Provider.of<ProfileServices>(context);
    return KeyboardDismisser(
      child: WillPopScope(
        onWillPop: () => willPopForLogginScreens(context),
        child: Scaffold(
          backgroundColor: mainBackgroundColor,
          body: _isLoadig
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
                          child: Form(
                            key: _formState,
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
                                CustomFormInput(
                                  hintText: "Email",
                                  prefix: Icons.email,
                                  validator: (value) => value.isEmpty
                                      ? "Please write E-Mail!"
                                      : isValidEmail(value)
                                          ? null
                                          : "Please write valid E-Mail",
                                  onSaved: (v) => _userSignInModel.email = v,
                                ),
                                CustomFormInput(
                                  obscureText: true,
                                  hintText: "Password",
                                  prefix: Icons.lock,
                                  validator: (value) => value.isEmpty
                                      ? "Please write Password"
                                      : null,
                                  onSaved: (v) => _userSignInModel.password = v,
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                CustomFormButton(
                                  onTap: onSignIn,
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
      ),
    );
  }
}
