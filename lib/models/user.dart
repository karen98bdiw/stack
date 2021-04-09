import 'package:flutter/cupertino.dart';
import 'package:stack/utils/enums.dart';

class User extends ChangeNotifier {
  String name;
  String surname;
  String email;
  String id;
  String companyId;
  UserType type;

  CurentUserState state;

  User(
      {this.email,
      this.id,
      this.name,
      this.state,
      this.surname,
      this.type,
      this.companyId});

  factory User.fromJson(json) {
    return User(
      companyId: json["companyId"],
      name: json["name"],
      email: json["email"],
      id: json["id"],
      surname: json["surname"],
      type: json["type"] == "Buisnes" ? UserType.Buisnes : UserType.UsualUser,
    );
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();

    data["email"] = this.email;
    data["surname"] = this.surname;
    data["email"] = this.email;
    data["type"] = this.type;
    data["companyId"] = this.companyId;
    data["id"] = this.id;
    data["type"] = this.type == UserType.Buisnes ? "Buisnes" : "UsualUser";
    return data;
  }

  // User({this.email, this.name, this.surname, this.id});
}
