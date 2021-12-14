import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/events_controller.dart';

class EventsView extends GetView<EventsController> {
  // final controlller = Get.find<EventsController>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: controller.obx(
        (state) => 
          ListView.builder(
            itemCount : state.length ,
            itemBuilder: (_,index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(child: Center(child: Text(state[index].title),),),
            ),
          ),
        onEmpty: NoEventsFeedback(),
        onError: (error) => ErrorFeedback(error),
      ),
    );
  }

  Center ErrorFeedback(String? error) => Center(child: Text(error != null? error : ''),);

  SizedBox NoEventsFeedback() =>
     SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children:[ 
            Image.asset('assets/images/no_events.png',width: 300,height: 200,),
            Text('Não há eventos disponíveis ${controller.text }', style: TextStyle(color: Colors.grey),)
          ]
        ),
    );
}


