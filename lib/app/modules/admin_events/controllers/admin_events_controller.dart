import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';

class AdminEventsController extends GetxController {
  //TODO: Implement AdminEventsController
  final StorageProvider storage;

  final count = 0.obs;

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
  void increment() => count.value++;

  logout() {
    this.storage.clear();
    Get.rootDelegate.offNamed('login');
  }
}
