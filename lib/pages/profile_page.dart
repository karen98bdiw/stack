import 'package:flutter/material.dart';
import 'package:stack/pages/favorite_companies.dart';
import 'package:stack/services/profile_services.dart';
import 'package:stack/utils/contstats.dart';

class ProfileUserPage extends StatefulWidget {
  ProfileUserPage({Key key}) : super(key: key);

  @override
  _ProfileUserPageState createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage> {
  List<Widget> listWidget = [];

  @override
  void initState() {
    super.initState();

    ProfileServices().getCompanies();
    for (int i = 0; i < FavoriteCompanies.faforiteList.length; ++i) {
      listWidget.add(StackCard());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body());
  }

  Widget _body() {
    return SingleChildScrollView(
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
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
                                    image: AssetImage("assets/user_photo.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            height: 40,
                            margin:
                                EdgeInsets.only(top: 20, left: 10, right: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 10, primary: Colors.pink),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Join the queue ",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Icon(Icons.add),
                                ],
                              ),
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => AddStreamPage()));
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
                              "Jora Mkrtchyan",
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
                              "Dental Clinic",
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
      Container(
          height: MediaQuery.of(context).size.height * 0.47,
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.45),
          child: ListView.builder(
              itemCount: listWidget.length,
              itemBuilder: (context, index) {
                return StackCard();
              }))
    ]));
  }
}

class StackCard extends StatefulWidget {
  StackCard({Key key}) : super(key: key);

  @override
  _StackCardState createState() => _StackCardState();
}

class _StackCardState extends State<StackCard> {
  bool isSwitched = false;
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: InkWell(
        onTap: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => CompanyInfoPage()));
        },
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(65)),
                        image: DecorationImage(
                            image: AssetImage("assets/user_photo.jpg"),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Worker name"),
                        Container(
                            //width: MediaQuery.of(context).size.width * 0.45,
                            child: Text("Work Type")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    primary: mainButtonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(80))),
                  ),
                  child: Text("Join"),
                  onPressed: () {},
                ),
              ),
            )
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
