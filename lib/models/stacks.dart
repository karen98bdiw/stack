import 'package:flutter/cupertino.dart';

class Stacks {
  static List<Widget> listStackWidgets = [];
  //static List<String> names = [];
  //static List<Image> images = [];
  //static int count;

  // Basket(this.counts);

  static inserWidget(Widget count) {
    listStackWidgets.add(count);
  }

  // static insertName(String name) {
  //   names.add(name);
  // }
  // static insertImage(Image image){
  //   images.add(image);
  // }
}