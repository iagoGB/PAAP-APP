import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/shared/widgets/admin_app_bar.dart';
import 'package:paap_app/app/modules/shared/widgets/error_feedback.dart';
import 'package:paap_app/app/modules/shared/widgets/event_card.dart';
import 'package:paap_app/app/modules/shared/widgets/no_events_feedback.dart';

import '../controllers/admin_events_controller.dart';

class AdminEventsView extends GetView<AdminEventsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        iconColor: Get.isDarkMode ? Colors.yellow : Colors.black,
        controller: controller,
      ),
      body: controller.obx(
        (state) => ListView.builder(
          itemCount: state.length,
          itemBuilder: (_, index) => EventCard(
            event: state[index],
            onTapFunction: controller.toDetails,
            textColor: Get.theme.primaryColor,
          ),
        ),
        onEmpty: NoEventsFeedback(
            'assets/images/no_past_events.png', 'Nenhum evento no momento'),
        onError: (error) => ErrorFeedback(error),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        color: Color(0x00ffffff),
        // padding: EdgeInsets.symmetric(vertical: 8, horizontal: 100),
        // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        height: 50,
        width: 130,
        child: ElevatedButton(
          onPressed: () => controller.toCreateEvent(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.add_circle_sharp),
              Container(margin: EdgeInsets.only(right: 5)),
              Text(
                "Criar",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          style: ElevatedButton.styleFrom(
            primary: Get.theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
