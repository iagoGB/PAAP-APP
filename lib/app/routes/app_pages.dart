import 'package:get/get.dart';

import 'package:paap_app/app/modules/home/bindings/home_binding.dart';
import 'package:paap_app/app/modules/home/views/home_view.dart';
import 'package:paap_app/app/modules/login/login_binding.dart';
import 'package:paap_app/app/modules/login/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
