import 'package:get/get.dart';

import '../controllers/admin_events_controller.dart';

class AdminEventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminEventsController>(
      () => AdminEventsController(),
    );
  }
}
