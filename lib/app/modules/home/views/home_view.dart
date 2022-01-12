import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paap_app/app/modules/home/controllers/home_controller.dart';
import '../../../routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  var controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        //This router outlet handles the appbar and the bottom navigation bar
        final currentIndex = controller.getCurrentIndex(currentRoute);
        return Scaffold(
          body: GetRouterOutlet(
            initialRoute: Routes.EVENTS,
            // anchorRoute: Routes.HOME,
            key: Get.nestedKey(Routes.HOME),
          ),
          bottomNavigationBar:
              customBottomNavBar(controller, currentIndex, delegate),
        );
      },
    );
  }
}

BottomNavigationBar customBottomNavBar(controller, currentIndex, delegate) {
  return BottomNavigationBar(
    showUnselectedLabels: false,
    currentIndex: currentIndex,
    onTap: (value) => controller.changeTabIndex(value, delegate),
    selectedIconTheme: Get.theme.primaryIconTheme,
    unselectedIconTheme: Get.theme.iconTheme,
    selectedItemColor: Get.theme.primaryIconTheme.color,
    // selectedItemColor: const Color.fromRGBO(234, 125, 91, 0.8),
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.people_alt_outlined),
        label: 'Perfil',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.notifications),
        label: 'Notificações',
      ),
    ],
  );
}
