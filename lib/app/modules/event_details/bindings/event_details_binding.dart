import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/api_provider.dart';
import 'package:paap_app/app/data/providers/event_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';
import 'package:paap_app/app/data/providers/user_provider.dart';
import 'package:paap_app/app/modules/root/controllers/root_controller.dart';

import '../controllers/event_details_controller.dart';

class EventDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(
      () => ApiProvider(),
    );
    Get.lazyPut<StorageProvider>(
      () => StorageProvider(),
    );
    Get.lazyPut<RootController>(
      () => RootController(),
    );

    Get.lazyPut<EventProvider>(
      () => EventProvider(Get.find(), Get.find()),
    );
    Get.lazyPut<UserProvider>(
      () => UserProvider(Get.find(), Get.find()),
    );
    Get.lazyPut<EventDetailsController>(
      () => EventDetailsController(
          Get.parameters['eventId'] ?? '', Get.find(), Get.find(), Get.find()),
    );
  }
}
