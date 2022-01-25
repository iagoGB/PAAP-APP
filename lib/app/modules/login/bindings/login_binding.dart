import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/api_provider.dart';
import 'package:paap_app/app/data/providers/auth_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';
import 'package:paap_app/app/data/providers/user_provider.dart';
import 'package:paap_app/app/modules/home/controllers/home_controller.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(
      () => ApiProvider(),
    );
    Get.lazyPut<StorageProvider>(
      () => StorageProvider(),
    );
    Get.lazyPut<UserProvider>(
      () => UserProvider(Get.find(), Get.find()),
    );
    Get.lazyPut<HomeController>(
      () =>
          HomeController(storageProvider: Get.find(), userProvider: Get.find()),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<AuthProvider>(
      () => AuthProvider(),
    );
  }
}
