import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stack/models/logining_models.dart';
import 'package:stack/utils/enums.dart';
import 'package:stack/widgets/helpers.dart';

class LoginigService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  static final LoginigService _registrationService = LoginigService._internal();
  LoginigService._internal();

  factory LoginigService() {
    return _registrationService;
  }

  Future<bool> signUp({UserSignUpModel model}) async {
    try {
      var res = await auth.createUserWithEmailAndPassword(
          email: model.email, password: model.password);
      if (res == null) {
        return false;
      }

      store.collection("users").doc(res.user.uid).set(model.toJson());

      return true;
    } catch (e) {
      showError(e.toString());
      print("error in sign up ${e.toString()}");
      return false;
    }
  }

  Future<SingInResponse> singIn({UserSingInModel model}) async {
    try {
      var res = await auth.signInWithEmailAndPassword(
          email: model.email, password: model.password);
      if (res.user == null) {
        return SingInResponse(state: SingInState.Failed, id: null);
      }
      return SingInResponse(state: SingInState.Succses, id: res.user.uid);
    } catch (e) {
      showError(e.toString());
      print("error in sing in ${e.toString()}");
      return SingInResponse(state: SingInState.Failed, id: null);
    }
  }
}
