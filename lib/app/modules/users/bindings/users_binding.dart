import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';

import '../controllers/users_controller.dart';

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorageProvider>(
      () => StorageProvider(),
    );
    Get.lazyPut<UsersController>(
      () => UsersController(storageProvider: Get.find()),
    );
  }
}
