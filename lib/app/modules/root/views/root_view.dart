import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/root/controllers/root_controller.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class RootView extends GetView<RootController> {
  final controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, current) {
        return Scaffold(
          // drawer: DrawerWidget(),
          appBar: null,
          body: GetRouterOutlet(
            initialRoute: Routes.LOGIN,
          ),
        );
      },
    );
  }
}
