import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/shared/widgets/admin_app_bar.dart';
import 'package:paap_app/app/modules/shared/widgets/error_feedback.dart';
import 'package:paap_app/app/modules/shared/widgets/event_card.dart';
import 'package:paap_app/app/modules/shared/widgets/floating_button.dart';
import 'package:paap_app/app/modules/shared/widgets/no_events_feedback.dart';

import '../controllers/admin_events_controller.dart';

class AdminEventsView extends GetView<AdminEventsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        icon: Icons.exit_to_app_outlined,
        iconColor: Get.isDarkMode ? Colors.yellow : Colors.black,
        onTapFunction: controller.logout,
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
      floatingActionButton: FloatingCreateButton(
        Get.theme.primaryColor,
        controller.toCreateEvent,
      ),
    );
  }
}
