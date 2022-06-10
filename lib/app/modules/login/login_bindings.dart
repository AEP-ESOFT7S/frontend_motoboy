import 'package:get/get.dart';
import 'package:verydeli/app/modules/login/login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
