import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/api_provider.dart';
import 'package:paap_app/app/data/providers/event_provider.dart';
import 'package:paap_app/app/modules/events/controllers/events_controller.dart';

class EventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventsController>(() => EventsController(Get.find()),);
    Get.lazyPut<ApiProvider>(() => ApiProvider(),);
    Get.lazyPut<EventProvider>(() => EventProvider(Get.find()),);
    
  }
}
