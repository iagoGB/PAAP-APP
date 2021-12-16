import 'dart:async';

import 'package:get/get.dart';
import 'package:paap_app/app/data/models/event_model.dart';
import 'package:paap_app/app/data/providers/event_provider.dart';

class EventsController extends GetxController with StateMixin {
  final EventProvider eventProvider;
  String text = 'Buêêêên';
  // final events = <Event>[].obs;

  EventsController(this.eventProvider);

  @override
  void onInit() {
    super.onInit();
  }
  
  void getOpens() async {
    await this.eventProvider.getOpens().then((events) {
      events.forEach((e)  => e.toString());
      change(events, status: events.length == 0? RxStatus.empty(): RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error("Erro ao buscar eventos abertos"));
    });
  }

  @override
  void onReady() {
    super.onReady();
    this.getOpens();
  }

  @override
  void onClose() {}
}
