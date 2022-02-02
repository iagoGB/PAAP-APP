import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paap_app/app/modules/shared/widgets/waiting_feedback.dart';

import '../controllers/event_details_controller.dart';

class EventDetailsView extends GetView<EventDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Get.isDarkMode ? Colors.yellow : Colors.black,
          ),
          onPressed: () =>
              // Navigator.of(context).pop();
              controller.getBack(),
        ),
        actions: [
          Obx(
            () => controller.userStatus.value != 'isPresent' &&
                    controller.userStatus.value != 'isEnrolled' &&
                    !controller.isAdmin.value
                ? IconButton(
                    onPressed: () => controller.subscribeToEvent(),
                    icon: Icon(
                      Icons.check,
                      color: Get.isDarkMode ? Colors.yellow : Colors.black,
                    ),
                  )
                : Container(),
          ),
          Obx(
            () => controller.isAdmin.value
                ? IconButton(
                    onPressed: () => controller.editEvent(controller.eventId),
                    icon: Icon(
                      Icons.edit,
                      color: Get.isDarkMode ? Colors.yellow : Colors.black,
                    ),
                  )
                : Container(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return WaitingFeedback();
        } else if (controller.error.value) {
          return Center(
            child: Text('Erro ao carregar detalhes do evento'),
          );
        } else {
          return RawScrollbar(
              isAlwaysShown: true,
              thumbColor: const Color.fromRGBO(234, 125, 91, 0.8),
              radius: Radius.circular(20),
              thickness: 8,
              child: SingleChildScrollView(child: mountEventDetails()));
        }
      }),
      bottomNavigationBar: Obx(
        () => Visibility(
          visible: !(controller.isLoading.value || controller.error.value),
          replacement: Container(
            width: 1,
            height: 1,
          ),
          child: mountBottomNavigationBar(),
        ),
      ),
      floatingActionButton: Obx(
        () => controller.userStatus.value == 'isEnrolled'
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
            : Container(),
      ),
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
              child: Obx(
                () => controller.isAdmin.value
                    ? Image(
                        image: NetworkImage(event.qrCode ?? ''),
                      )
                    : Container(),
              ),
            ),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.access_time_filled_rounded),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat("EEEE ',' d 'de' MMMM", "pt-BR")
                              .format(event.dateTime!)
                              .capitalize!,
                          style: TextStyle(
                            height: 1.2,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          DateFormat("'Às 'HH:mm 'BRT'", "pt-BR")
                              .format(event.dateTime!),
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
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
                icon: Icons.record_voice_over_outlined,
                text: 'Palestrado por ' + controller.getSpeakers(),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Image(
                image: NetworkImage(event.picture!),
              ),
            ),
            Text(event.description ?? ''),
            Obx(
              () => controller.isAdmin.value
                  ? Column(
                      children: [
                        CustomRow(
                          icon: Icons.supervisor_account_rounded,
                          text:
                              "Inscritos: ${controller.event.enrolled!.length.toString()}",
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: controller.event.enrolled!.length == 0
                              ? [Text('Nenhum usuário inscrito até o momento')]
                              : controller.event.enrolled!
                                  .map((e) => Text(e))
                                  .toList(),
                        ),
                        CustomRow(
                          icon: Icons.supervisor_account_rounded,
                          text:
                              "Presentes: ${controller.event.attended!.length.toString()}",
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: controller.event.attended!.length == 0
                              ? [
                                  Text(
                                      'Nenhum usuário registrou presença até o momento')
                                ]
                              : controller.event.attended!
                                  .map((e) => Text(e))
                                  .toList(),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Row CustomRow({required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
          ),
        ),
      ],
    );
  }

  Widget mountBottomNavigationBar() {
    return Obx(
      () => controller.isAdmin.value
          ? Container(
              child: Text(''),
            )
          : Container(
              decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    blurRadius: 5,
                    spreadRadius: 5,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Obx(
                () {
                  switch (controller.userStatus.value) {
                    case 'isEnrolled':
                      return ElevatedButton(
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
                      );

                    case 'isPresent':
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Get.theme.primaryColor,
                        ),
                        onPressed: () => controller.subscribing.value
                            ? null
                            : controller.downloadCertificate(),
                        child: controller.subscribing.value
                            ? CircularProgressIndicator()
                            : Text(
                                'Baixar certificado',
                                style: TextStyle(
                                  color: Get.theme.secondaryHeaderColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      );

                    default:
                      return ElevatedButton(
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
                      );
                  }
                },
              ),
            ),
    );
  }
}
