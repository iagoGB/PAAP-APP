import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/routes/app_pages.dart';

import '../controllers/event_details_controller.dart';

class EventDetailsView extends GetView<EventDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(() {
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
      ),
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
              onPressed: () => controller.readQrCode(),
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                event.title!,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: CustomRow(
                icon: Icons.access_time_filled_rounded,
                text: event.dateTime!,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: CustomRow(
                icon: Icons.location_pin,
                text: event.location!,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: CustomRow(
                icon: Icons.check_circle_rounded,
                text: 'Carga horária de ${event.workload.toString()}h',
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: CustomRow(
                icon: Icons.supervisor_account_rounded,
                text: 'Palestrado por ' + controller.getSpeakers(),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Image(
                image: NetworkImage(event.picture!),
              ),
            ),
            Text(event.location!)
          ],
        ),
      ),
    );
  }

  Row CustomRow({required IconData icon, required String text}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Icon(icon),
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5,
        ),
      ),
      Flexible(
          child: Text(
        text,
        style: TextStyle(
          height: 1.2,
          fontSize: 12,
        ),
      ))
    ]);
  }
}
