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
                controller: controller.firstNameController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) => validateNotNull(value!),
              ),
              TextFormField(
                controller: controller.lastNameController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Sobrenome'),
                validator: (value) => validateNotNull(value!),
              ),
              TextFormField(
                controller: controller.cepController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'CEP'),
                validator: (value) => validateNotNull(value!),
              ),
              TextFormField(
                controller: controller.cityController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Cidade'),
                validator: (value) => validateNotNull(value!),
              ),
              TextFormField(
                controller: controller.neighborhoodController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Bairro'),
                validator: (value) => validateNotNull(value!),
              ),
              TextFormField(
                controller: controller.addressController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(labelText: 'Logradouro'),
                validator: (value) => validateNotNull(value!),
              ),
              TextFormField(
                controller: controller.numberController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Número'),
                validator: (value) => validateNotNull(value!),
              ),
              TextFormField(
                controller: controller.complementController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Complemento'),
                validator: (value) => validateNotNull(value!),
              ),
              TextFormField(
                controller: controller.emailController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => validateEmail(value!),
              ),
              TextFormField(
                controller: controller.passwordController,
                textInputAction: TextInputAction.done,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
                validator: (value) => validateNotNull(value!),
              ),
              TextFormField(
                textInputAction: TextInputAction.go,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirmar senha'),
                validator: (value) => validateNotNull(value!),
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

  String? validateNotNull(String value) {
    if (value.isNotEmpty) {
      return null;
    } else {
      return 'Este campo não pode ser vázio!';
    }
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Este campo não pode ser vázio!';
    } else if (value.isEmail) {
      return null;
    } else {
      return 'Insira um email válido!';
    }
  }
}
