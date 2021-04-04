import 'package:stack/utils/enums.dart';

class UserSignUpModel {
  String email;
  String password;
  String name;
  String surname;

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();

    data["name"] = this.name;
    data["surname"] = this.surname;
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
