import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paap_app/app/modules/events/events_view.dart';
import 'package:paap_app/app/modules/notifications/notifications_view.dart';
import 'package:paap_app/app/modules/search/search_view.dart';

class HomeController extends GetxController {
  int currentIndex = 0;
  final screens = [
    EventsView(),
    SearchView(),
    NotificationsView()
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void changeTabIndex(int index) {
    this.currentIndex = index;
    this.update();
  }
}
