import 'package:fire_auth/controller/login_controller.dart';
import 'package:fire_auth/view/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeProvider with ChangeNotifier{
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
    // final signUpPro = Provider.of<SignUpProvider>(ctx, listen: false);
    final loginPro = Provider.of<LogInProvider>(ctx, listen: false);
    // final homePro = Provider.of<HomeProvider>(ctx, listen: false);
    loginPro.emailController.clear();
    loginPro.passwordController.clear();
    // signUpPro.nameControl.clear();
    // signUpPro.emailControl.clear();
    // signUpPro.passwordControl.clear();
    // signUpPro.homeTownControl.clear();
    // signUpPro.contactControl.clear();
    // homePro.changeNameControl.clear();
    // homePro.changeContactControl.clear();
    // homePro.changeHomeTownControl.clear();    
    // homePro.imagePath='';
    notifyListeners();
  }
  
  
  }