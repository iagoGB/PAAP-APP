import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';

import '../controllers/admin_events_controller.dart';

class AdminEventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorageProvider>(
      () => StorageProvider(),
    );
    Get.lazyPut<AdminEventsController>(
      () => AdminEventsController(Get.find()),
    );
  }
}
