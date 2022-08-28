import 'package:flutter/cupertino.dart';

class LogInProvider with ChangeNotifier{
final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

}