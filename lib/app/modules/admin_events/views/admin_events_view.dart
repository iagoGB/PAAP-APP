import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_events_controller.dart';

class AdminEventsView extends GetView<AdminEventsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdminEventsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AdminEventsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
