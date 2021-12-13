import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/events_controller.dart';

class EventsView extends GetView<EventsController> {
  // final controlller = Get.find<EventsController>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children:[ 
              Image.asset('assets/images/no_events.png',width: 300,height: 200,),
              Text('Não há eventos disponíveis ${controller.text }', style: TextStyle(color: Colors.grey),)
            ]
          ),
      ),
    );
  }
}
