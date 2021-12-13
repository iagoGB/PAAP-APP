import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'NotificationsView is working ${ controller.count }',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
