import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack/models/company_model.dart' as comp;
import 'package:stack/pages/login_register_screens/sign_in_screen.dart';
import 'package:stack/services/company_services.dart';
import 'package:stack/services/profile_services.dart';
import 'package:stack/utils/contstats.dart';
import 'package:stack/utils/enums.dart';
import 'package:stack/widgets/app_bars.dart';
import 'package:stack/widgets/buttons.dart';
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
                    _homeTopView(),
                    titleText("No stack adjusted yet"),
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

  Widget _homeTopView() {
    return Stack(
      children: [
        ClippedAppBar(),
        Positioned(
          child: _userInfoView(),
          right: scaffoldPadding.right / 2,
          top: 20,
        ),
        Positioned(
          bottom: 40,
          child: _buisnesStateView(),
        )
      ],
    );
  }

  Widget _userInfoView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            usualInfoText(
                "${profileServices.user.name ?? ""} ${profileServices.user.surname ?? ""}"),
            usualInfoText("${profileServices.user.email ?? ""}"),
            usualInfoText(
              profileServices.user.type == UserType.Buisnes
                  ? "Company User"
                  : "Usual User",
            ),
          ],
        ),
        SizedBox(
          width: 40,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: Icon(
                  Icons.exit_to_app_outlined,
                  color: mainButtonColor,
                  size: 30,
                ),
                onPressed: () {}),
            SizedBox(
              height: 5,
            ),
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: mainButtonColor,
                  size: 30,
                ),
                onPressed: () {}),
          ],
        )
      ],
    );
  }

  Widget _buisnesStateView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: titleText("Looks Like you dont make your stack?"),
        ),
        CustomButton(
          radius: 20,
          title: "Construct Buisnes",
          onTap: () async {
            CompanyServices().company.name = "AlfaDent";
            CompanyServices().company.description = "Dental Clinic";
            CompanyServices().company.weekFirstWorkDay = "Sun";
            CompanyServices().company.weekLastWorkDay = "Fri";
            CompanyServices().company.workDayStartTime = DateTime.now();
            CompanyServices().company.workDayEndTime = DateTime.now();
            CompanyServices().company.stacks = [];
            CompanyServices().company.addStack(
                stack: comp.Stack(
                    description: "Some great Worker",
                    id: CompanyServices().company.stacks == null
                        ? "0"
                        : CompanyServices().company.stacks.length.toString(),
                    worker: "Worket number 1"));

            await CompanyServices().addCompany();
          },
        ),
      ],
    );
  }
}
