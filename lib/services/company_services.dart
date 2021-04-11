import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stack/models/company_model.dart';
import 'package:stack/services/profile_services.dart';

class CompanyServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  Company company;

  static final CompanyServices companyServices = CompanyServices._internal();

  CompanyServices._internal();

  factory CompanyServices() {
    return companyServices;
  }

  Future<bool> addCompany(Company company) async {
    company.id =
        ProfileServices().user.id + DateTime.now().toString() + company.name;
    company.ownerId = ProfileServices().user.id;
    try {
      await store.collection("companies").doc(company.id).set(company.toJson());
      ProfileServices().user.companyId = company.id;
      await store
          .collection("users")
          .doc("${company.ownerId}")
          .update(ProfileServices().user.toJson())
          .catchError((e) {
        print("error in update${e.toString()}");
      });

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
