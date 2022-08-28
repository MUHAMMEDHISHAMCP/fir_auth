import 'package:fire_auth/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginOptions extends StatelessWidget {
  const LoginOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: (size / 2.5 - 30),
          child: const Divider(
            thickness: 1,
            color: kBlack,
          ),
        ),
        const Text(
          'Or login with',
          style: TextStyle(fontWeight: FontWeight.bold, color: kBlack54),
        ),
        SizedBox(
          width: (size / 2.5 - 30),
          child: const Divider(
            thickness: 1,
            color: kBlack,
          ),
        ),
      ],
    );
  }
}
