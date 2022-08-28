// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:fire_auth/controller/signup_controller.dart';
import 'package:fire_auth/view/signup/widget/signup_img.dart';
import 'package:fire_auth/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final signUpController = context.read<SignUpProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_){
   signUpController.emailController.clear();
   signUpController.passwordController.clear();
   signUpController.userNameController.clear();
   // ignore: invalid_use_of_protected_member
   signUpController.notifyListeners();
    });
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Consumer<SignUpProvider>(
                  builder: (context, value, child) {
                    return Form(
                      key: value.formKey,
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 8),
                          Text('SignUp',
                              style: GoogleFonts.permanentMarker(fontSize: 30)),
                          kHeight20,
                          const SignUpImageWidget(),
                          kHeight20,
                          TextFormField(
                            controller: value.userNameController,
                            obscureText: false,
                            autofocus: false,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: 'UserName',
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.black))),
                            validator: (inputValue) {
                              if (inputValue == null || inputValue.isEmpty) {
                                return 'Enter userName';
                              } else {
                                return null;
                              }
                            },
                          ),
                          kHeight20,
                          TextFormField(
                            controller: value.emailController,
                            obscureText: false,
                            autofocus: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'Email',
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.black))),
                            validator: (inputValue) {
                              if (inputValue == null || inputValue.isEmpty) {
                                return 'Please enter email';
                              } else {
                                return null;
                              }
                            },
                          ),
                          kHeight20,
                          TextFormField(
                            controller: value.passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                            ),
                            validator: (inputValue) {
                              if (inputValue == null || inputValue.isEmpty) {
                                return 'EnterPassword';
                              } else {
                                return null;
                              }
                            },
                          ),
                          kHeight10,
                          ElevatedButton(
                            onPressed: () async {
                              final errorMsg =
                             await signUpController.signUpUser(context);

                             signUpController.checkFormField(context, errorMsg);
                            },
                            child: const Text('SignUp'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
