import 'package:flutter/cupertino.dart';

class FavoriteCompanies{
 static List<Widget> faforiteList=[];

  static inserWidget(Widget count) {
    faforiteList.add(count);
  }
   static deletWidget() {
    faforiteList.removeLast();
  }
}
