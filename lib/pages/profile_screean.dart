import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack/models/stacks.dart';
import 'package:stack/pages/add_stream_page.dart';
import 'package:stack/services/company_services.dart';
import 'package:stack/services/profile_services.dart';
import 'package:stack/utils/contstats.dart';
import 'package:stack/utils/enums.dart';
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
        _sideMenu(),
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
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(46, 61, 77, 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 20),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _isSideMenuOpen = !_isSideMenuOpen;
                            });
                          },
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(65)),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/user_photo.jpg"),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.only(
                                      top: 20, left: 10, right: 10),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 10, primary: Colors.pink),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Create Business",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Icon(Icons.add),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddStreamPage()));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    ProfileServices().user.name +
                                        " " +
                                        ProfileServices().user.surname,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Armenia,Erevan,Abovyan 30",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    ProfileServices().user.type ==
                                            UserType.Buisnes
                                        ? "Buisnes Company"
                                        : "Usual User",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
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

  Widget _sideMenu() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        //decoration: BoxDecoration(),
        width: MediaQuery.of(context).size.width * 0.5,
        margin: EdgeInsets.symmetric(vertical: 50),
        // color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                child: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                ),
                Container(
                    child: Text("User",
                        style: TextStyle(color: Colors.white, fontSize: 18)))
              ],
            )),
            Container(
                child: Row(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.email,
                      color: Colors.white,
                      size: 30,
                    )),
                Text("Email",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            )),
            Container(
                child: Row(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 30,
                    )),
                Text("Phone",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            )),
            Container(
                child: Row(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 30,
                    )),
                Text("Settings",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            )),
            Container(
                child: Row(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 30,
                    )),
                Text("Log out",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            )),
          ],
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
