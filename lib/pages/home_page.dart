import 'package:flutter/material.dart';
import 'package:stack/pages/profile_page.dart';
import 'package:stack/pages/profile_screean.dart';
import 'package:stack/pages/search_queue_age.dart';

class HomePageUser extends StatefulWidget {
  static final routeName = "HomePageUser";

  int sectionIndex = 0;
  HomePageUser(this.sectionIndex);

  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  @override
  void initState() {
    print("user home page oppend");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.sectionIndex,
        items: [
          BottomNavigationBarItem(
              label: "Search Queue", icon: Icon(Icons.menu)),
          BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person)),
        ],
        onTap: (index) {
          setState(() {
            widget.sectionIndex = index;
          });
        },
      ),
      body: _body(),
    );
  }

  Widget _body() {
    switch (widget.sectionIndex) {
      case 0:
        return SearchQueuePage();
        break;
      case 1:
        return ProfileUserPage();
      default:
        return SearchQueuePage();
    }
  }
}
