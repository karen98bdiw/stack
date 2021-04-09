import 'package:flutter/material.dart';
import 'package:stack/utils/contstats.dart';

class StackCard extends StatefulWidget {
  String name;
  String description;

  StackCard({this.description, this.name});

  @override
  _StackCardState createState() => _StackCardState();
}

class _StackCardState extends State<StackCard> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: Row(
        children: [
          Flexible(
            flex: 3,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name ?? "name"),
                    Text(widget.description ?? "description "),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "on/off Stack",
                    textAlign: TextAlign.center,
                  ),
                  margin: EdgeInsets.only(top: 5),
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      print(isSwitched);
                    });
                  },
                  activeTrackColor: mainButtonColor,
                  activeColor: mainButtonColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
