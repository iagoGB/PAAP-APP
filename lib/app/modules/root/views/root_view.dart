import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/root/controllers/root_controller.dart';
import 'package:paap_app/app/modules/root/views/drawer.dart';
import 'package:paap_app/app/routes/app_pages.dart';


class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, current) {
        final title = current?.location;
        return Scaffold(
          drawer: DrawerWidget(),
          appBar: AppBar(
            title: Text(title ?? ''),
            centerTitle: true,
          ),
          body: GetRouterOutlet(
            initialRoute: Routes.HOME,
            // anchorRoute: '/',
            // filterPages: (afterAnchor) {
            //   return afterAnchor.take(1);
            // },
          ),
        );
      },
    );
  }
}
