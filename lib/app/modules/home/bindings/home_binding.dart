import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/api_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';
import 'package:paap_app/app/data/providers/user_provider.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorageProvider>(() => StorageProvider());
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<UserProvider>(() => UserProvider(Get.find(), Get.find()));
    Get.lazyPut<HomeController>(
      () =>
          HomeController(storageProvider: Get.find(), userProvider: Get.find()),
    );
  }
}
