import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/auth_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';
import 'package:paap_app/app/modules/home/controllers/home_controller.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorageProvider>(
      () => StorageProvider(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<AuthProvider>(
      () => AuthProvider(),
    );
  }
}
