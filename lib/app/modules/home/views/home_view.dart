import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paap_app/app/modules/home/controllers/home_controller.dart';
import '../../../routes/app_pages.dart';

import 'dart:math' as math;

class HomeView extends GetView<HomeController> {
  var controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        //This router outlet handles the appbar and the bottom navigation bar
        final currentIndex = controller.getCurrentIndex(currentRoute);
        return Scaffold(
          appBar: mountAppBar(),
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

  AppBar mountAppBar() {
    return AppBar(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      centerTitle: true,
      title: customLogo(),
      actions: [
        customAvatar(controller),
      ],
      leading: Container(
        margin: EdgeInsets.only(left: 20),
        child: IconButton(
          icon: Transform(
            transform: Matrix4.rotationY(math.pi),
            child: Icon(Icons.exit_to_app_outlined),
          ),
          color: Get.isDarkMode ? Colors.yellow : Colors.black,
          onPressed: () {
            controller.logout();
          },
        ),
      ),
    );
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

  Widget customAvatar(controller) {
    String urlImage =
        'https://fcdocente-teste.s3.sa-east-1.amazonaws.com/usuarios/default-avatar.png';
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Stack(children: [
        Center(
          child: CircularProgressIndicator(
            value: 0.5,
            strokeWidth: 1,
          ),
        ),
        Center(
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(urlImage),
          ),
        ),
      ]),
    );
  }
}
