import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/data/models/event_model.dart';
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
        title: Text('EventDetailsView ${controller.eventId}'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (controller.error.value) {
            return Center(
              child: Text('Erro ao carregar evento'),
            );
          } else {
            return mountEventDetails();
          }
        }
      }),
      bottomNavigationBar: Obx(
        () => controller.isLoading.value || controller.error.value
            ? Container()
            : Container(
                decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.9),
                        blurRadius: 5,
                        spreadRadius: 5,
                        offset: Offset(0, 3))
                  ],
                ),
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: controller.isSubscribed.value
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Get.theme.primaryColor,
                        ),
                        onPressed: () => controller.subscribing.value
                            ? null
                            : controller.unsubscribeToEvent(),
                        child: controller.subscribing.value
                            ? CircularProgressIndicator()
                            : Text(
                                'Remover inscrição',
                                style: TextStyle(
                                  color: Get.theme.secondaryHeaderColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Get.theme.primaryColor,
                        ),
                        onPressed: () => controller.subscribing.value
                            ? null
                            : controller.subscribeToEvent(),
                        child: controller.subscribing.value
                            ? CircularProgressIndicator()
                            : Text(
                                ' Participar deste evento',
                                style: TextStyle(
                                  color: Get.theme.secondaryHeaderColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
              ),
      ),
      floatingActionButton: Obx(() => controller.isSubscribed.value
          ? FloatingActionButton.extended(
              onPressed: () => null,
              label: Row(children: [
                Icon(Icons.qr_code_2_outlined),
                Text(
                  'Presença',
                  style: TextStyle(
                    color: Get.theme.secondaryHeaderColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            )
          : Container()),
    );
  }

  Widget mountEventDetails() {
    var event = controller.event;
    return Center(
        child: Column(
      children: [
        Text(
          event.title!,
        ),
        CustomRow(
          icon: Icons.access_time_filled_rounded,
          text: event.dateTime!,
        ),
        CustomRow(
          icon: Icons.location_pin,
          text: event.location!,
        ),
        CustomRow(
            icon: Icons.check_circle_rounded,
            text: 'Carga horária de ${event.workload.toString()}h'),
        CustomRow(
            icon: Icons.supervisor_account_rounded,
            text: 'Palestrado por ' + controller.getSpeakers()),
        Image(
          image: NetworkImage(event.picture!),
        ),
        Text(event.location!)
      ],
    ));
  }

  Row CustomRow({required IconData icon, required String text}) {
    return Row(children: [Icon(icon), Text(text)]);
  }
}
