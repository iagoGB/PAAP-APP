import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/api_provider.dart';
import 'package:paap_app/app/data/providers/category_provider.dart';
import 'package:paap_app/app/data/providers/event_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';

import '../controllers/edit_event_controller.dart';

class EditEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorageProvider>(
      () => StorageProvider(),
    );
    Get.lazyPut<ApiProvider>(
      () => ApiProvider(),
    );
    Get.lazyPut<CategoryProvider>(
      () => CategoryProvider(Get.find()),
    );
    Get.lazyPut<EventProvider>(
      () => EventProvider(Get.find(), Get.find()),
    );
    Get.lazyPut<EditEventController>(
      () => EditEventController(
        Get.parameters['eventId'] ?? '',
        eventProvider: Get.find(),
        categoryProvider: Get.find(),
      ),
    );
  }
}
