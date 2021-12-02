import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
       return  Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: customLogo(),
            actions: [
                  customAvatar(),
            ],
          ),
          body: SafeArea(
            child: IndexedStack(
              index: controller.currentIndex,
              children: controller.screens
            ),
          ),
          bottomNavigationBar: customBottomNavBar(controller),
      );
    });
  }

  BottomNavigationBar customBottomNavBar(controller) {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      currentIndex: controller.currentIndex,
      onTap: (index) => controller.changeTabIndex(index),
      selectedItemColor: const Color.fromRGBO(234, 125, 91, 0.8),
      items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label:'Home'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label:'Pesquisar'
      ),
       BottomNavigationBarItem(
        icon: Icon(Icons.notifications),
        label:'Notificações'
      ),

    ],);
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

  Widget customAvatar() {
    return Container(
            margin: const EdgeInsets.only(right: 10),
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage('https://image.shutterstock.com/image-photo/profile-picture-smiling-millennial-asian-600w-1836020740.jpg')
            ),
          );
  }
}
