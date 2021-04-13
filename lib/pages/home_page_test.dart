import 'package:flutter/material.dart';
import 'package:stack/pages/profile_screean.dart';
import 'package:stack/pages/streams_screen.dart';

class HomePageBuisnes extends StatefulWidget {
  int sectionIndex;

  static final routeName = "HomePageBuisnes";

  HomePageBuisnes({this.sectionIndex = 0});

  @override
  _HomePageBuisnesState createState() => _HomePageBuisnesState();
}

class _HomePageBuisnesState extends State<HomePageBuisnes> {
  //int sectionIndex = widget.index;
  //
  //
  @override
  void initState() {
    print("home page buisnes  is oppened");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(label: "Strems", icon: Icon(Icons.menu)),
          BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person)),
        ],
        onTap: (index) {
          setState(() {
            widget.sectionIndex = index;
          });
        },
        currentIndex: widget.sectionIndex,
        backgroundColor: Colors.white,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    switch (widget.sectionIndex) {
      case 0:
        return StreamsPage();
        break;
      case 1:
        return ProfilePage();
      default:
        return StreamsPage();
    }
  }
}
