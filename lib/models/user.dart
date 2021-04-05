import 'package:flutter/cupertino.dart';
import 'package:stack/utils/enums.dart';

class User extends ChangeNotifier {
  String name;
  String surname;
  String email;
  String id;

  CurentUserState state;

  // User({this.email, this.name, this.surname, this.id});
}
