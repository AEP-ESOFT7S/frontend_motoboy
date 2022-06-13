import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verydeli/app/modules/login/login_repository.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final LoginRepository _loginRepository = LoginRepository();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _isObscure = true.obs;

  bool get getIsObscure => _isObscure.value;
  set setIsObscure(bool value) => _isObscure.value = value;

  void login() {
    if (formKey.currentState!.validate()) {
      _loginRepository.login(emailController.text).then(
        (value) {
          Get.offAllNamed('/home');
        },
      ).catchError((_) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(_.message)));
      });
    }
  }
}
