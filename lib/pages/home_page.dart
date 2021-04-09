import 'package:flutter/material.dart';
import 'package:stack/pages/profile_screean.dart';
import 'package:stack/pages/streams_screen.dart';

class HomePage extends StatefulWidget {
  int sectionIndex = 0;
  HomePage(this.sectionIndex);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //int sectionIndex = widget.index;
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
