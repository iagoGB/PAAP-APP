import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/api_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';
import 'package:paap_app/app/data/providers/user_provider.dart';

import '../controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(
      () => ApiProvider(),
    );
    Get.lazyPut<StorageProvider>(
      () => StorageProvider(),
    );
    Get.lazyPut<UserProvider>(
      () => UserProvider(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut<RootController>(
      () =>
          RootController(userProvider: Get.find(), storageProvider: Get.find()),
    );
  }
}
