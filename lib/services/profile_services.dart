import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:stack/models/user.dart';
import 'package:stack/utils/enums.dart';
import 'package:stack/widgets/helpers.dart';

class ProfileServices extends ChangeNotifier {
  final User user = User();
  final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;

  static final ProfileServices _profileServices = ProfileServices._internal();

  ProfileServices._internal();

  factory ProfileServices() {
    return _profileServices;
  }

  Future<bool> getProfile() async {
    try {
      var res = await store.collection("users").doc(user.id).get();
      print("profile:${res.data()}");
      user.name = res["name"];
      user.surname = res["surname"];
      user.email = res["email"];
      user.state = CurentUserState.Signed;
      notifyListeners();
      if (res == null) {
        return false;
      }
    } catch (e) {
      showError(e.toString());
      return false;
    }
  }

  Future<bool> logOut() async {
    try {
      await firebaseAuth.signOut();
      user.state = CurentUserState.NotSigned;
    } catch (e) {
      showError(e.toString());
    }
  }
}
