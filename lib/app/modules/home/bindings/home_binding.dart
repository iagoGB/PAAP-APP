import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorageProvider>(() => StorageProvider());
    Get.lazyPut<HomeController>(
      () => HomeController(storageProvider: Get.find()),
    );
  }
}
