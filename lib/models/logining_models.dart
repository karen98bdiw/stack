import 'package:stack/utils/enums.dart';

class UserSignUpModel {
  String email;
  String password;
  String name;
  String surname;
  UserType type;
  String id;

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["surname"] = this.surname;
    data["email"] = this.email;
    data["type"] = this.type == UserType.UsualUser ? "UsualUser" : "Buisnes";
    return data;
  }
}

class UserSingInModel {
  String email;
  String password;
  String id;
}

class SingInResponse {
  SingInState state;
  String id;

  SingInResponse({this.state, this.id});
}
