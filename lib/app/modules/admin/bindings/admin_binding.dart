import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';
import '../controllers/admin_controller.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorageProvider>(() => StorageProvider());
    Get.lazyPut<AdminController>(() => AdminController());
  }
}
