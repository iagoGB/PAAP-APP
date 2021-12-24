import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/routes/app_pages.dart';

import '../controllers/event_details_controller.dart';

class EventDetailsView extends GetView<EventDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Navigator.of(context).pop();
            Get.rootDelegate.toNamed(Routes.HOME);
          },
        ),
        title: Text('EventDetailsView ${controller.productId}'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'EventDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
