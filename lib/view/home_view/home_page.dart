import 'dart:convert';

import 'package:fire_auth/controller/home_controller.dart';
import 'package:fire_auth/controller/login_controller.dart';
import 'package:fire_auth/controller/signup_controller.dart';
import 'package:fire_auth/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ActionType {
  logIn,
  signUp,
}

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  ActionType type;
  HomePage({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LogInProvider>();
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   final fff = context.read<SignUpProvider>();
    //   fff.loggedUserDetails.email;
    //   fff.loggedUserDetails.name;
    //   fff.loggedUserDetails.phoneNo;
    //   fff.newImage;
    // });
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.indigo.shade500,
              Colors.white54,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Consumer<SignUpProvider>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      type == ActionType.signUp
                          ? value.newImage.isEmpty
                              ? const CircleAvatar(
                                  radius: 100,
                                  backgroundImage:
                                      AssetImage('assets/userIcon.png'),
                                  child: Icon(Icons.add_a_photo),
                                )
                              : CircleAvatar(
                                  radius: 100,
                                  //   backgroundColor: kBlack,
                                  backgroundImage: MemoryImage(
                                    const Base64Decoder()
                                        .convert(value.newImage),
                                  ),
                                )
                          : loginProvider.loggedUserDetails.image == null
                              ? const CircleAvatar(
                                  radius: 100,
                                  backgroundImage:
                                      AssetImage('assets/userIcon.png'),
                                  child: Icon(Icons.add_a_photo),
                                )
                              : CircleAvatar(
                                  radius: 100,
                                  //   backgroundColor: kBlack,
                                  backgroundImage: MemoryImage(
                                    const Base64Decoder().convert(loginProvider
                                        .loggedUserDetails.image
                                        .toString()),
                                  ),
                                ),
                      kHeight20,
                      TextFormField(
                        controller: value.userNameController,
                        obscureText: false,
                        autofocus: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: type == ActionType.logIn
                                ? loginProvider.loggedUserDetails.name
                                : value.loggedUserDetails.name,
                            hintStyle: const TextStyle(fontSize: 20),
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                      ),
                      kHeight20,
                      TextFormField(
                        controller: value.emailController,
                        obscureText: false,
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: type == ActionType.logIn
                                ? loginProvider.loggedUserDetails.email
                                : value.loggedUserDetails.email,
                            hintStyle: TextStyle(
                                color: Colors.green.shade900, fontSize: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 0,
                                style: BorderStyle.solid,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                        readOnly: true,
                      ),
                      kHeight20,
                      TextFormField(
                        controller: value.mobNoController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Contact No',
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      kHeight10,
                      Consumer<HomeProvider>(
                        builder: (context, value, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // value.signUpUser(context);
                                  value.logOut(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 30),
                                  primary: Colors.red.shade700,
                                ),
                                child: const Text('LogOut'),
                              ),
                              kWidth10,
                              kWidth10,
                              ElevatedButton(
                                onPressed: () {
                                  
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 30),
                                  primary: Colors.blueAccent,
                                ),
                                child: const Text('Save'),
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
