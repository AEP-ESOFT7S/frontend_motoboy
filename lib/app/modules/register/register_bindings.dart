import 'package:get/get.dart';
import 'package:verydeli/app/modules/register/register_controller.dart';

class RegisterBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}
