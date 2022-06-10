import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verydeli/app/modules/register/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registre-se')),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Sobrenome'),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'CEP'),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Cidade'),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Bairro'),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(labelText: 'Logradouro'),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Número'),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Complemento'),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => validateEmail(value!),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              TextFormField(
                textInputAction: TextInputAction.go,
                decoration: const InputDecoration(labelText: 'Confirmar senha'),
              ),
              ElevatedButton(
                onPressed: () => controller.register(),
                child: const Text('Cadastrar'),
              ),
            ],
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
