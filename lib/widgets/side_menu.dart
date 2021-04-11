import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
