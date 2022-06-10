import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verydeli/app/modules/register/register_repository.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RegisterRepository _registerRepository = RegisterRepository();

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      // await _registerRepository.register();
      Get.toNamed('/home');
    }
  }
}
