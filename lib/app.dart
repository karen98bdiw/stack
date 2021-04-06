import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack/pages/home_screen_buisnes.dart';
import 'package:stack/pages/home_screen_user.dart';
import 'package:stack/pages/login_register_screens/sign_in_screen.dart';
import 'package:stack/pages/login_register_screens/sign_up_screen.dart';
import 'package:stack/services/profile_services.dart';
import 'package:stack/utils/contstats.dart';

class StackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => ProfileServices(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: mainColor,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: SignInScreen.routeName,
        routes: {
          SignInScreen.routeName: (c) => SignInScreen(),
          SignUpScreen.routeName: (c) => SignUpScreen(),
          HomeScreenUser.routeName: (c) => HomeScreenUser(),
          HomeScreenBuisnes.routeName: (c) => HomeScreenBuisnes(),
        },
      ),
    );
  }
}
