import 'package:get/get.dart';

import 'package:paap_app/app/data/providers/storage_provider.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class UsersController extends GetxController {
  final StorageProvider storageProvider;

  UsersController({
    required this.storageProvider,
  });

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  logout() {
    this.storageProvider.clear();
    Get.rootDelegate.offAndToNamed(Routes.LOGIN);
  }
}
