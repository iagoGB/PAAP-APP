import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/event_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class AdminEventsController extends GetxController with StateMixin {
  final StorageProvider storage;
  final EventProvider eventProvider;
  String query = '';
  Timer? debouncer;

  AdminEventsController(this.storage, this.eventProvider);

  @override
  void onInit() {
    super.onInit();
    this.getAll();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  logout() {
    this.storage.clear();
    Get.rootDelegate.offNamed('login');
  }

  toCreateEvent() {
    Get.rootDelegate.toNamed(Routes.CREATE_EVENT);
  }

  toDetails(id) {
    Get.rootDelegate.toNamed(Routes.EVENT_DETAILS(id.toString()));
  }

  getAll() async {
    await this.eventProvider.getAll().then((value) {
      // for (var i = 0; i < 10; i++) {
      //   value.add(value[1]);
      // }
      change(value, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error());
    });
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  searchEvent(String query) async => debounce(() async {
        await eventProvider.getByQuery(query).then(
              (value) => value.length == 0
                  ? change(value, status: RxStatus.empty())
                  : change(value, status: RxStatus.success()),
              onError: (err) => change(err, status: RxStatus.error()),
            );
        // if (!mounted) return;
      });
}
