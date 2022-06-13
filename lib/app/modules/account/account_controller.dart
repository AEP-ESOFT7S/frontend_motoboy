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
    final String user = _storage.read('userData');

    final json = RegisterResponse.fromJson(user);

    firstNameController.text = json.firstName;
    lastNameController.text = json.lastName;
    cpfController.text = json.cpf;
    phoneController.text = json.phone;
    cepController.text = json.cep;
    cityController.text = json.city;
    neighborhoodController.text = json.neighborhood;
    addressController.text = json.address;
    numberController.text = json.number;
    complementController.text = json.complement;
    emailController.text = json.email;

    super.onInit();
  }

  final _index = 1.obs;
  int get getCurrentIndex => _index.value;
  set setCurrentIndex(int value) => _index.value = value;

  final _darkMode = false.obs;
  bool get getIsDarkMode => _darkMode.value;
  set setIsDarkMode(bool value) => _darkMode.value = value;
}
