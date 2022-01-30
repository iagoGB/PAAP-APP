import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/event_provider.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class EventsController extends GetxController
    with StateMixin, GetSingleTickerProviderStateMixin {
  final EventProvider eventProvider;
  late TabController tabController;
  List<Tab> eventTabs = [
    Tab(child: Text('ABERTOS', style: TextStyle(fontSize: 12))),
    Tab(child: Text('INSCRITO', style: TextStyle(fontSize: 12))),
    Tab(child: Text('HISTÓRICO', style: TextStyle(fontSize: 12)))
  ];
  // final events = <Event>[].obs;

  EventsController(this.eventProvider);

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: eventTabs.length);
    tabController.addListener(() {
      if (tabController.indexIsChanging ||
          tabController.index != tabController.previousIndex) {
        print(tabController.previousIndex);
        loadEvents(tabController.index);
      }
    });
  }

  void getOpens() async {
    await this.eventProvider.getOpens().then((events) {
      change([], status: RxStatus.loading());
      change(events,
          status: events.length == 0 ? RxStatus.empty() : RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error("Erro ao buscar eventos abertos"));
    });
  }

  void getEnrolleds() async {
    change([], status: RxStatus.loading());
    await this.eventProvider.getEnrolleds().then((events) {
      change(events,
          status: events.length == 0 ? RxStatus.empty() : RxStatus.success());
    }, onError: (err) {
      change(
        null,
        status: RxStatus.error("Erro ao buscar eventos que você se increveu"),
      );
    });
  }

  void getHistoric() async {
    change([], status: RxStatus.loading());
    await this.eventProvider.getHistoric().then((events) {
      change(events,
          status: events.length == 0 ? RxStatus.empty() : RxStatus.success());
    }, onError: (err) {
      change(
        null,
        status: RxStatus.error("Erro ao buscar eventos que você participou"),
      );
    });
  }

  @override
  void onReady() {
    super.onReady();
    this.getOpens();
  }

  @override
  void onClose() {}

  void toDetailsEvent(id) {
    Get.rootDelegate.toNamed(Routes.EVENT_DETAILS(id.toString()));
  }

  loadEvents(int value) {
    switch (value) {
      case 0:
        this.getOpens();
        break;
      case 1:
        this.getEnrolleds();
        break;
      case 2:
        this.getHistoric();
        break;
      default:
        this.getOpens();
    }
  }
}
