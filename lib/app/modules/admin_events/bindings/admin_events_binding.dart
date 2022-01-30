import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/api_provider.dart';
import 'package:paap_app/app/data/providers/event_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';

import '../controllers/admin_events_controller.dart';

class AdminEventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(
      () => ApiProvider(),
    );
    Get.lazyPut<StorageProvider>(
      () => StorageProvider(),
    );
    Get.lazyPut<EventProvider>(
      () => EventProvider(Get.find(), Get.find()),
    );
    Get.lazyPut<AdminEventsController>(
      () => AdminEventsController(Get.find(), Get.find()),
    );
  }
}
