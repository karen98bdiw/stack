import 'package:flutter/cupertino.dart';
import 'package:stack/utils/enums.dart';

class User extends ChangeNotifier {
  String name;
  String surname;
  String email;
  String id;
  UserType type;

  CurentUserState state;

  User({this.email, this.id, this.name, this.state, this.surname, this.type});

  factory User.fromJson(json) {
    return User(
      name: json["name"],
      email: json["email"],
      id: json["id"],
      surname: json["surname"],
      type: json["type"] == "Buisnes" ? UserType.Buisnes : UserType.UsualUser,
    );
  }

  // User({this.email, this.name, this.surname, this.id});
}
