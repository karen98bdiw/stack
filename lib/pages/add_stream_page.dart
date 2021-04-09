import 'package:flutter/material.dart';
import 'package:stack/pages/additional_pageview.dart';
import 'package:stack/pages/info_pageview.dart';

class AddStreamPage extends StatefulWidget {
  AddStreamPage({Key key}) : super(key: key);

  @override
  _AddStreamPageState createState() => _AddStreamPageState();
}

class _AddStreamPageState extends State<AddStreamPage> {
  final controllerPageView = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return PageView(
      controller: controllerPageView,
      pageSnapping: true,
      children: [
        AdditionalPageView(
          controller: controllerPageView,
        ),
        InfoPageView()
      ],
    );
  }
}
