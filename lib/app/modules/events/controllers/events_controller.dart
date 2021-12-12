import 'package:get/get.dart';
import 'package:paap_app/app/data/models/event_model.dart';
import 'package:paap_app/app/data/providers/event_provider.dart';

class EventsController extends GetxController {
  EventProvider eventProvider= Get.find<EventProvider>();
  final events = <Event>[].obs;


  @override
  void onInit() {
    super.onInit();
    
  }
  
  Future<void> getAllEvents() async {
    print('executou');
    var teste = await this.eventProvider.getAllEvents();
    teste.forEach((element) {
      print(element.toString());
    });
  }

  @override
  void onReady() {
    super.onReady();
    this.getAllEvents();
    print('teste');
  }

  @override
  void onClose() {}
}
