import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paap_app/app/modules/admin/controllers/admin_controller.dart';
import '../../../routes/app_pages.dart';

class AdminView extends GetView<AdminController> {
  final controller = Get.find<AdminController>();
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        //This router outlet handles the appbar and the bottom navigation bar
        final currentIndex = controller.getCurrentIndex(currentRoute);
        return Scaffold(
          body: GetRouterOutlet(
            initialRoute: Routes.USERS,
            // anchorRoute: Routes.HOME,
            key: Get.nestedKey(Routes.ADMIN),
          ),
          bottomNavigationBar:
              customBottomNavBar(controller, currentIndex, delegate),
        );
      },
    );
  }
}

Widget customLogo() {
  return SizedBox(
    width: 63,
    height: 32,
    child: Image.asset(
      'assets/images/paap.png',
      alignment: Alignment.center,
      width: 63,
      height: 32,
    ),
  );
}

BottomNavigationBar customBottomNavBar(controller, currentIndex, delegate) {
  return BottomNavigationBar(
    showUnselectedLabels: true,
    currentIndex: currentIndex,
    onTap: (value) => controller.changeTabIndex(value, delegate),
    selectedItemColor: const Color.fromRGBO(234, 125, 91, 0.8),
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: 'Usuários',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today),
        label: 'Eventos',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.view_list_sharp),
        label: 'Categorias',
      ),
      // BottomNavigationBarItem(
      //     icon: Icon(Icons.calendar_today), label: 'Notificações'),
    ],
  );
}
