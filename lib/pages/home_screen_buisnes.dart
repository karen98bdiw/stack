import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack/pages/login_register_screens/sign_in_screen.dart';
import 'package:stack/services/profile_services.dart';
import 'package:stack/utils/contstats.dart';
import 'package:stack/utils/enums.dart';
import 'package:stack/widgets/app_bars.dart';
import 'package:stack/widgets/helpers.dart';

class HomeScreenBuisnes extends StatefulWidget {
  static final routeName = "HomeScreenBuisnes";

  @override
  _HomeScreenBuisnes createState() => _HomeScreenBuisnes();
}

class _HomeScreenBuisnes extends State<HomeScreenBuisnes> {
  ProfileServices profileServices;

  @override
  void initState() {
    ProfileServices().getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    profileServices = Provider.of<ProfileServices>(context);

    return WillPopScope(
      onWillPop: () async {
        var res = await willPopForHome(context: context);
        if (res) {
          await ProfileServices().logOut();
          Navigator.of(context).pop();
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: lightBackground,
        body: profileServices.user.state != CurentUserState.Signed
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClippedAppBar(),
                    Text("id:${profileServices.user.id ?? null}"),
                    Text("name:${profileServices.user.name ?? ""}"),
                    Text("surname:${profileServices.user.surname ?? ""}"),
                    Text("email:${profileServices.user.email ?? ""}"),
                    Text("tpye:${profileServices.user.type ?? ""}"),
                  ],
                ),
              ),
      ),
    );
  }
}
