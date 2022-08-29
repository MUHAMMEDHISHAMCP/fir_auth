import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_auth/model/user_data_model.dart';
import 'package:fire_auth/utils/snackbar.dart';
import 'package:fire_auth/view/home_view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final _auth = FirebaseAuth.instance;

class SignUpProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final mobNoController = TextEditingController();

  UserData userData = UserData();
  UserData loggedUserDetails = UserData();
  dynamic newUser;

  Future<String> signUpUser(context) async {
    final password = passwordController.text;
    // final email = emailController.text;
    // final userName = userNameController.text;

    if (password.length < 6 || newImage.isEmpty) {}
    try {
      newUser = await _auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) => addAllUserDetails(context, newImage));
      return Future.value("");
    } on FirebaseAuthException catch (e) {
      log("$e");
      return SnackBarWidget.checkFormFill(context, e.message);
    }
  }

  Future addAllUserDetails(context, String newImage) async {
    final fireSore = FirebaseFirestore.instance;

    User? user = _auth.currentUser;
    userData.email = user!.email!.trim();
    userData.name = userNameController.text.trim();
    userData.image = newImage;
    userData.phoneNo = mobNoController.text.isEmpty?null:mobNoController.text;
    await fireSore.collection("users").doc(user.uid).set(
          userData.toJson(),
        ).then((value) async {
          await  fireSore.collection("users").doc(user.uid).get().then((value) {
      loggedUserDetails = UserData.fromJson(value.data()!);
      notifyListeners();
    });
        },);
    notifyListeners();
   
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: ((context) =>  HomePage(type: ActionType.signUp,)),
        ),
        ((route) => false));
  }

  checkFormField(BuildContext context, errorMessage) async {
    if (errorMessage == "") {
      return;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
        SnackBarWidget.checkFormFill(context, errorMessage);
    }
  }

  String newImage = "";
  getImageFromGallery(conteex) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = File(pickedFile!.path).readAsBytesSync();
    newImage = base64Encode(bytes);
    notifyListeners();
  }
}

// class PickImageController extends ChangeNotifier {
//   String newImage = "";
//   getImageFromGallery(conteex) async {
//     XFile? pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     final bytes = File(pickedFile!.path).readAsBytesSync();
//     newImage = base64Encode(bytes);
//     notifyListeners();
//   }
// }
