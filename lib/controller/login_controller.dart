import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_auth/model/user_data_model.dart';
import 'package:fire_auth/utils/snackbar.dart';
import 'package:fire_auth/view/home_view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInProvider with ChangeNotifier {
  final fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Stream<User?> stream() => _auth.authStateChanges();
  UserData loggedUserDetails = UserData();

  bool isLoading = false;

  Future<String> logInUser(context) async {
    isLoading = true;
    notifyListeners();
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        getAllUserData(context);
        //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage(),), (route) => false);
      });
      isLoading = false;
      notifyListeners();
      return Future.value("");
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      isLoading = false;
      notifyListeners();
      return SnackBarWidget.checkFormFill(context, e.message);
    }
  }

  formValidation(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      logInUser(context);
    }
  }

  getAllUserData(context) async {
    User? user = _auth.currentUser;
    await fireStore.collection("users").doc(user!.uid).get().then((value) => {
          loggedUserDetails = UserData.fromJson(value.data()!),
          notifyListeners(),
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>  HomePage(type: ActionType.logIn,),
              ),
              (route) => false),
        });
  }
}
