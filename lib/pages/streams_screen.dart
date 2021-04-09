import 'package:flutter/material.dart';

class StreamsPage extends StatefulWidget {
  StreamsPage({Key key}) : super(key: key);

  @override
  _StreamsPageState createState() => _StreamsPageState();
}

class _StreamsPageState extends State<StreamsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(child:Text("Streams page")),
    );
  }
}