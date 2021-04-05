import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack/pages/login_register_screens/sign_in_screen.dart';
import 'package:stack/services/profile_services.dart';
import 'package:stack/utils/enums.dart';
import 'package:stack/widgets/helpers.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        body: profileServices.user.state != CurentUserState.Signed
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("id:${profileServices.user.id ?? null}"),
                    Text("name:${profileServices.user.name ?? ""}"),
                    Text("surname:${profileServices.user.surname ?? ""}"),
                    Text("email:${profileServices.user.email ?? ""}"),
                  ],
                ),
              ),
      ),
    );
  }
}
