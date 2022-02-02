import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/shared/widgets/admin_app_bar.dart';
import 'package:paap_app/app/modules/shared/widgets/custom_search_bar.dart';
import 'package:paap_app/app/modules/shared/widgets/error_feedback.dart';
import 'package:paap_app/app/modules/shared/widgets/event_card.dart';
import 'package:paap_app/app/modules/shared/widgets/floating_button.dart';
import 'package:paap_app/app/modules/shared/widgets/no_events_feedback.dart';
import 'package:paap_app/app/modules/shared/widgets/search_widget.dart';

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
      body: Column(
        children: [
          CustomSearchBar(
            labelText: 'Eventos',
            query: controller.query,
            onChanged: controller.searchEvent,
            hintText: 'Nome do evento',
          ),
          Expanded(
            child: controller.obx(
              (state) => RawScrollbar(
                isAlwaysShown: true,
                thumbColor: const Color.fromRGBO(234, 125, 91, 0.8),
                radius: Radius.circular(20),
                thickness: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (_, index) => EventCard(
                      event: state[index],
                      onTapFunction: controller.toDetails,
                      textColor: Get.theme.primaryColor,
                    ),
                  ),
                ),
              ),
              onEmpty: SingleChildScrollView(
                child: NoEventsFeedback('assets/images/no_past_events.png',
                    'Nenhum evento localizado'),
              ),
              onError: (error) => ErrorFeedback(error),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingCreateButton(
        Get.theme.primaryColor,
        controller.toCreateEvent,
      ),
    );
  }
}
