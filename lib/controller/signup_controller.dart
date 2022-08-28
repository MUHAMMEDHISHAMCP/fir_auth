import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_auth/model/user_data_model.dart';
import 'package:fire_auth/view/home_view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/snackbar.dart';

final auth = FirebaseAuth.instance;

class SignUpProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  UserData userData = UserData();
  UserData loggedUserDetails = UserData();
  dynamic newUser;

  Future<String> signUpUser(context) async {
    final password = passwordController.text;

    if (password.length < 6) {
   SnackBarWidget.checkFormFill(context, "Password should be at least 6 characters");
}
    try {
      newUser = await auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) => addAllUserDetails(context));
      return Future.value("");
    } on FirebaseAuthException catch (e) {
      log("$e");
  return Future.value(e.message);
    }
  }

  Future addAllUserDetails(context) async {
    final fireSore = FirebaseFirestore.instance;

    User? user = auth.currentUser;
    userData.email = user!.email!.trim();
    userData.name = userNameController.text.trim();
    userData.id = user.uid;
    fireSore.collection("users").doc(user.uid).set(
          userData.toJson(),
        );
    await fireSore.collection("users").doc(user.uid).get().then((value) {
      loggedUserDetails = UserData.fromJson(value.data()!);
      log(loggedUserDetails.name.toString());
      notifyListeners();
    });
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: ((context) => const HomePage()),
        ),
        ((route) => false));
  }

  checkFormField(BuildContext context, errorMessage) async {
    if (errorMessage == "") {
      return;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //  SnackBarWidget.chekFormFill(context, errorMessage);
    }
  }
}
