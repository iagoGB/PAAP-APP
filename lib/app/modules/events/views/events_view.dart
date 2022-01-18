import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/events_controller.dart';

class EventsView extends GetView<EventsController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          title: Text(
            'Eventos',
            style: TextStyle(color: Get.theme.primaryColor),
          ),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 30),
            child: Container(
              height: 30,
              child: TabBar(
                controller: controller.tabController,
                // onTap: (value) => controller.loadEvents(value),
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(horizontal: 40),
                padding: EdgeInsets.zero,
                indicatorColor:
                    Get.isDarkMode ? Get.theme.primaryColor : Colors.grey[700],
                labelColor: Get.isDarkMode ? Colors.yellow : Colors.grey[700],
                unselectedLabelColor:
                    Get.isDarkMode ? Colors.white : Colors.grey[400],
                tabs: controller.eventTabs,
              ),
            ),
          ), // Espaço onde vc pode inserir o proximo evento em destaque
        ),
        body: TabBarView(
          controller: controller.tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            openEvents(),
            enrolledEvents(),
            historicEvents(),
          ],
        ),
      ),
    );
  }

  Scaffold openEvents() {
    return Scaffold(
      body: controller.obx(
        (state) => ListView.builder(
          itemCount: state.length,
          itemBuilder: (_, index) => buildCard(state[index]),
        ),
        onEmpty: NoEventsFeedback(
          'assets/images/no_events.png',
          'Não há eventos disponíveis',
        ),
        onError: (error) => ErrorFeedback(error),
      ),
    );
  }

  Scaffold enrolledEvents() {
    return Scaffold(
      body: controller.obx(
        (state) => ListView.builder(
          itemCount: state.length,
          itemBuilder: (_, index) => buildCard(state[index]),
        ),
        onEmpty: NoEventsFeedback(
          'assets/images/no_saved_events.png',
          'Você não está inscrito em nenhum evento',
        ),
        onError: (error) => ErrorFeedback(error),
      ),
    );
  }

  Scaffold historicEvents() {
    return Scaffold(
      body: controller.obx(
        (state) => ListView.builder(
          itemCount: state.length,
          itemBuilder: (_, index) => buildCard(state[index]),
        ),
        onEmpty: NoEventsFeedback('assets/images/no_past_events.png',
            'Você ainda não esteve presente em nenhum evento'),
        onError: (error) => ErrorFeedback(error ?? 'Erro ao buscar eventos'),
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
                            DateFormat("d 'de' MMM '-' HH:mm", "pt-BR")
                                .format(event.dateTime)
                                .toUpperCase(),
                            style: TextStyle(
                              color: Get.theme.primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            event.title,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(bottom: 20),
                          ),
                          Text(
                            event.category,
                            style: TextStyle(fontSize: 8),
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
                            image: NetworkImage(event.picture != 'default.png'
                                ? event.picture
                                : 'https://fcdocente-teste.s3.sa-east-1.amazonaws.com/eventos/paap.png'),
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

  SizedBox NoEventsFeedback(String img, String text) => SizedBox(
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(img, width: 250, height: 250, fit: BoxFit.contain),
          Text(
            text,
            style: TextStyle(color: Colors.grey),
          )
        ]),
      );
}
