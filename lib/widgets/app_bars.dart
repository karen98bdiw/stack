import 'package:flutter/material.dart';
import 'package:stack/utils/contstats.dart';
import 'package:stack/widgets/helpers.dart';

class ClippedAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AppBarClipper(context: context),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 250,
        color: mainBackgroundColor,
      ),
    );
  }
}
