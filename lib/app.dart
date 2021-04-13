import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack/models/company_model.dart';
import 'package:stack/pages/home_page.dart';
import 'package:stack/pages/home_page_test.dart';
import 'package:stack/pages/home_screen_buisnes.dart';
import 'package:stack/pages/login_register_screens/sign_in_screen.dart';
import 'package:stack/pages/login_register_screens/sign_up_screen.dart';
import 'package:stack/pages/profile_screean.dart';
import 'package:stack/services/profile_services.dart';
import 'package:stack/utils/contstats.dart';

class StackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfileServices>(
            create: (c) => ProfileServices()),
        ChangeNotifierProvider<Company>(create: (c) => Company()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: mainColor,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: SignInScreen.routeName,
        routes: {
          SignInScreen.routeName: (c) => SignInScreen(),
          SignUpScreen.routeName: (c) => SignUpScreen(),
          HomeScreenBuisnes.routeName: (c) => HomeScreenBuisnes(),
          ProfilePage.routeName: (c) => ProfilePage(),
          HomePageBuisnes.routeName: (c) => HomePageBuisnes(
                sectionIndex: 0,
              ),
          HomePageUser.routeName: (c) => HomePageUser(1),
        },
      ),
    );
  }
}
