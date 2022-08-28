import 'package:fire_auth/utils/colors.dart';
import 'package:flutter/material.dart';

class SignUpImageWidget extends StatelessWidget {
  const SignUpImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105,
      width: 105,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
        const   CircleAvatar(
            backgroundColor: kBlack,
            backgroundImage: AssetImage('assets/userIcon.png',)
         
          ),
          Positioned(
            bottom: 0,
            right: -25,
            child: RawMaterialButton(
              onPressed: () async {},
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
  }
}
