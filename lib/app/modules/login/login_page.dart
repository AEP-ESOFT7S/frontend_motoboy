import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verydeli/app/modules/login/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Verydeli', style: TextStyle(fontSize: 28)),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => validateEmail(value!),
                ),
                TextFormField(decoration: const InputDecoration(labelText: 'Senha')),
                ElevatedButton(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      Get.offAllNamed('/home');
                    }
                  },
                  child: const Text('Conectar'),
                ),
                TextButton(
                  onPressed: () => Get.toNamed('/register'),
                  child: const Text('registrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateEmail(String value) {
    String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Insira um email válido!';
    } else {
      return null;
    }
  }
}
