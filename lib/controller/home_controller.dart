import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_auth/controller/login_controller.dart';
import 'package:fire_auth/controller/signup_controller.dart';
import 'package:fire_auth/model/user_data_model.dart';
import 'package:fire_auth/utils/snackbar.dart';
import 'package:fire_auth/view/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeProvider with ChangeNotifier {
  final auth = FirebaseAuth.instance;

  final userNameController = TextEditingController();
  final mobNoController = TextEditingController();
  final emailController = TextEditingController();

  UserData userData = UserData();
  UserData loggedUserDetails = UserData();

  updateUserDetails(context) async {
    final userName = userNameController.text;
    final mobNo = mobNoController.text;
    final profile =
        Provider.of<SignUpProvider>(context, listen: false).newImage;

    if (userName.isEmpty || mobNo.length < 10) {
      return SnackBarWidget.checkFormFill(context, "Enter Correct Values");
    }
    User? user = auth.currentUser;

    emailController.text = user!.email.toString();

    FirebaseFirestore.instance.collection("users").doc(user.uid).update({
      'name': userName,
      'phoneNo': mobNo,
      'profile': newImage.isEmpty ? profile : newImage
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get()
          .then((value) {
        loggedUserDetails = UserData.fromJson(value.data()!);
      });
    });
    SnackBarWidget.checkFormFill(context, "Update Successfully");
  }

  void logOut(context) async {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              'Logout !!',
              style: TextStyle(color: Colors.red),
            ),
            content: const Text('Are you sure to want to logout?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text(
                  'No',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    disposeVariables(ctx);
                  }).then((value) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                    emailController.clear();
                    mobNoController.clear();
                    userNameController.clear();
                  });
                },
                child: const Text('Yes',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }

  void disposeVariables(ctx) {
    final loginPro = Provider.of<LogInProvider>(ctx, listen: false);
    loginPro.emailController.clear();
    loginPro.passwordController.clear();
    notifyListeners();
  }

  String newImage = "";
  updateImageFromGallery(conteex) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = File(pickedFile!.path).readAsBytesSync();
    newImage = base64Encode(bytes);
    notifyListeners();
  }
}
