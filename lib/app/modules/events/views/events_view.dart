import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/events_controller.dart';

class EventsView extends GetView<EventsController> {
  // final controlller = Get.find<EventsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (state) => ListView.builder(
          itemCount: state.length,
          itemBuilder: (_, index) => buildCard(state[index]),
        ),
        onEmpty: NoEventsFeedback(),
        onError: (error) => ErrorFeedback(error),
      ),
    );
  }

  Widget buildCard(event) => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            margin: EdgeInsets.all(5),
            elevation: 3,
            child: InkWell(
              onTap: () {
                controller.toDetailsEvent(event.id);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.dateTime.toUpperCase(),
                            style: TextStyle(
                                color: Color(0xff00A294),
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            event.title,
                            style: TextStyle(
                                color: Color(0xff050505),
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                              margin: EdgeInsetsDirectional.only(bottom: 20)),
                          Text(
                            event.category,
                            style: TextStyle(
                              fontSize: 8,
                              color: Color(0xff050505),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.only(right: 12, left: 12),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Ink.image(
                            width: 80,
                            height: 80,
                            image: NetworkImage(event.picture),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Center ErrorFeedback(String? error) => Center(
        child: Text(error != null ? error : ''),
      );

  SizedBox NoEventsFeedback() => SizedBox(
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/images/no_events.png',
            width: 300,
            height: 200,
          ),
          Text(
            'Não há eventos disponíveis ${controller.text}',
            style: TextStyle(color: Colors.grey),
          )
        ]),
      );
}
