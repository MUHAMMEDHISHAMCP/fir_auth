import 'dart:convert';

import 'package:fire_auth/controller/home_controller.dart';
import 'package:fire_auth/controller/login_controller.dart';
import 'package:fire_auth/controller/signup_controller.dart';
import 'package:fire_auth/view/home_view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProfilePic extends StatelessWidget {
  ProfilePic({Key? key, required this.type}) : super(key: key);
  ActionType type;
  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LogInProvider>();
 final editProvider = context.watch<HomeProvider>();
    return Consumer<SignUpProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: (){
           // print('fdsjk');
           editProvider.updateImageFromGallery(context);
          },
          child: type == ActionType.signUp
              ? value.newImage.isEmpty || editProvider.newImage.isEmpty
                  ? const CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/userIcon.png'),
                      child: Icon(Icons.add_a_photo),
                    )
                  : CircleAvatar(
                      radius: 100,
                      //   backgroundColor: kBlack,
                      backgroundImage: MemoryImage(
                        const Base64Decoder().convert(value.newImage),
                      ),
                    )
              : loginProvider.loggedUserDetails.image == null
                  ? const CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/userIcon.png'),
                      child: Icon(Icons.add_a_photo),
                    )
                  : editProvider.newImage.isNotEmpty? CircleAvatar(
                      radius: 100,
                      //   backgroundColor: kBlack,
                      backgroundImage: MemoryImage(
                        const Base64Decoder().convert(
                            editProvider.newImage),
                      ),
                    ):CircleAvatar(
                      radius: 100,
                      //   backgroundColor: kBlack,
                      backgroundImage: MemoryImage(
                        const Base64Decoder().convert(
                            loginProvider.loggedUserDetails.image.toString()),
                      ),
                    )
                
        );
      },
    );
  }
}
