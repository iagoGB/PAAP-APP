import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/events/controllers/events_controller.dart';

class EventsView extends GetView<EventsController> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children:[ 
              Image.asset('assets/images/no_events.png',width: 300,height: 200,),
              const Text('Não há eventos disponíveis', style: TextStyle(color: Colors.grey),)
            ]
          ),
      ),
    );
  }
}
