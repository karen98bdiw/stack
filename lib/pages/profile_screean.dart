import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack/models/stacks.dart';
import 'package:stack/pages/add_stream_page.dart';
import 'package:stack/services/company_services.dart';
import 'package:stack/services/profile_services.dart';
import 'package:stack/utils/contstats.dart';
import 'package:stack/utils/enums.dart';
import 'package:stack/widgets/profile_top_bar.dart';
import 'package:stack/widgets/side_menu.dart';
import 'package:stack/widgets/stack_card.dart';

class ProfilePage extends StatefulWidget {
  static final routeName = "ProfileScreen";

  // final List<Widget> listStreams;
  //ProfilePage([this.listStreams]);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileServices profileServices;

  List<Widget> listStacks = [];
  bool _isSideMenuOpen = true;
  double screenWidth;
  double screenHeight;
  final Duration duration = const Duration(milliseconds: 500);

  void sideBarToogler() {
    setState(() {
      _isSideMenuOpen = !_isSideMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    profileServices = Provider.of<ProfileServices>(context);

    // listStacks = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: _isSideMenuOpen ? null : myBackgroundColor,
      body: Stack(children: [
        SideMenu(),
        _body(),
      ]),
    );
  }

  @override
  void initState() {
    if (CompanyServices().company == null) {
      print("user have not company");
    } else {
      print("user have company");
      print(CompanyServices().company.toJson());
    }
    for (var item in Stacks.listStackWidgets) {
      listStacks.add(item);
    }
    super.initState();
  }

  Widget _body() {
    return AnimatedPositioned(
      duration: duration,
      top: _isSideMenuOpen ? 0 : 0.1 * screenHeight,
      bottom: _isSideMenuOpen ? 0 : 0.1 * screenWidth,
      left: _isSideMenuOpen ? 0 : 0.6 * screenWidth,
      right: _isSideMenuOpen ? 0 : -0.4 * screenWidth,
      child: Material(
        elevation: 5,
        borderRadius:
            _isSideMenuOpen ? null : BorderRadius.all(Radius.circular(10)),
        child: SingleChildScrollView(
          child: Stack(children: [
            ProfileTopBar(
              sideMenuTogler: sideBarToogler,
            ),
            if (CompanyServices().company != null &&
                CompanyServices().company?.stacks != null)
              Container(
                  height: MediaQuery.of(context).size.height * 0.47,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.45),
                  child: ListView.builder(
                      itemCount: CompanyServices().company.stacks.length,
                      itemBuilder: (context, index) {
                        return StackCard(
                          description: CompanyServices()
                              .company
                              .stacks[index]
                              .description,
                          name: CompanyServices().company.stacks[index].worker,
                        );
                      }))
          ]),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 0);
    path.quadraticBezierTo(
        size.width / 1.3, size.height, size.width, size.height - 150);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
