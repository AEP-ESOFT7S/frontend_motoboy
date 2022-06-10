import 'package:get/get.dart';
import 'package:verydeli/app/modules/login/login_bindings.dart';
import 'package:verydeli/app/modules/login/login_page.dart';
import 'package:verydeli/app/modules/register/register_bindings.dart';
import 'package:verydeli/app/modules/register/register_page.dart';
import 'package:verydeli/app/modules/splash/splash_bindings.dart';
import 'package:verydeli/app/modules/splash/splash_page.dart';

part 'routes.dart';

abstract class Pages {
  static final pages = [
    GetPage(name: Routes.INITIAL, page: () => const SplashPage(), binding: SplashBindings()),
    GetPage(name: Routes.LOGIN, page: () => const LoginPage(), binding: LoginBindings()),
    GetPage(name: Routes.REGISTER, page: () => const RegisterPage(), binding: RegisterBindings()),
  ];
}
