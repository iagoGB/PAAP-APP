import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/api_provider.dart';
import 'package:paap_app/app/data/providers/category_provider.dart';
import 'package:paap_app/app/data/providers/event_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';

import '../controllers/create_event_controller.dart';

class CreateEventBinding extends Bindings {
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
    Get.lazyPut<CreateEventController>(
      () => CreateEventController(
        Get.parameters['eventId'] ?? '',
        eventProvider: Get.find(),
        categoryProvider: Get.find(),
      ),
    );
  }
}
