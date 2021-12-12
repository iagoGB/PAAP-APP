import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/event_provider.dart';
import 'package:paap_app/app/modules/events/controllers/events_controller.dart';

class EventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventsController>(() => EventsController(),);
    Get.lazyPut<EventProvider>(() => EventProvider(),);
  }
}
