import 'package:flutter/material.dart';
import 'package:stack/pages/add_stream_page.dart';
import 'package:stack/pages/profile_screean.dart';
import 'package:stack/services/profile_services.dart';
import 'package:stack/utils/enums.dart';

class ProfileTopBar extends StatelessWidget {
  final Function sideMenuTogler;

  ProfileTopBar({this.sideMenuTogler});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
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
                  onTap: sideMenuTogler,
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
                                  image: AssetImage("assets/user_photo.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                        if (ProfileServices().user.type == UserType.Buisnes)
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
                                    "Create Business",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Icon(Icons.add),
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddStreamPage()));
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
                            ProfileServices().user.type == UserType.Buisnes
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
    );
  }
}
