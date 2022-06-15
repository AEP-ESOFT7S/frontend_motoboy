import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:verydeli/app/data/models/register_response.dart';

class AccountController extends GetxController {
  final _storage = GetStorage();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController complementController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    final String json = _storage.read('userData');

    final user = RegisterResponse.fromJson(json);

    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
    cpfController.text = user.cpf;
    phoneController.text = user.phone;
    cepController.text = user.cep;
    cityController.text = user.city;
    neighborhoodController.text = user.neighborhood;
    addressController.text = user.address;
    numberController.text = user.number;
    complementController.text = user.complement;
    emailController.text = user.email;

    super.onInit();
  }

  final _index = 1.obs;
  int get getCurrentIndex => _index.value;
  set setCurrentIndex(int value) => _index.value = value;
}
