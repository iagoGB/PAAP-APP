import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';

class AdminEventsController extends GetxController {
  final StorageProvider storage;

  AdminEventsController(this.storage);

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
    this.storage.clear();
    Get.rootDelegate.offNamed('login');
  }
}
