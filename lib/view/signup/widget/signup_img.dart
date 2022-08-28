import 'dart:convert';

import 'package:fire_auth/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpImageWidget extends StatelessWidget {
  const SignUpImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, value, child) {
        return SizedBox(
          height: 105,
          width: 105,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              value.newImage.isNotEmpty
                  ? CircleAvatar(
                      radius: 100,
                      //   backgroundColor: kBlack,
                      backgroundImage: MemoryImage(
                        const Base64Decoder().convert(value.newImage),
                      ),
                    )
                  : const CircleAvatar(
                      radius: 100,
                      //   backgroundColor: kBlack,
                      backgroundImage: AssetImage('assets/userIcon.png')),
              Positioned(
                bottom: 0,
                right: -25,
                child: RawMaterialButton(
                  onPressed: () async {
                    value.getImageFromGallery(context);
                  },
                  elevation: 4,
                  fillColor: Colors.grey,
                  padding: const EdgeInsets.all(6),
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add_a_photo),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
