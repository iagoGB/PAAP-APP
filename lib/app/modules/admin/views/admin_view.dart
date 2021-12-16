import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paap_app/app/modules/home/controllers/home_controller.dart';
import '../../../routes/app_pages.dart';

class AdminView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        //This router outlet handles the appbar and the bottom navigation bar
        final currentIndex = controller.getCurrentIndex(currentRoute);
        return Scaffold(
          body: GetRouterOutlet(
            initialRoute: Routes.ADMIN_EVENTS,
            // anchorRoute: Routes.HOME,
            key: Get.nestedKey(Routes.ADMIN),
          ),
          bottomNavigationBar: customBottomNavBar(controller, currentIndex , delegate),
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
      selectedItemColor: const Color.fromRGBO(234, 125, 91, 0.8),
      items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label:'Home'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.speaker),
        label:'Pesquisar'
      ),
       BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today),
        label:'Notificações'
      ),

    ],);
  }

//   Widget customLogo() {
//     return SizedBox(
//         width: 63,
//         height: 32,
//         child: Image.asset(
//             'assets/images/paap.png',
//             alignment: Alignment.center,
//             width: 63,
//             height: 32,
//           ),
//       );
//   }

//   Widget customAvatar() {
//     return Container(
//             margin: const EdgeInsets.only(right: 10),
//             child: const CircleAvatar(
//               radius: 20,
//               backgroundColor: Colors.transparent,
//               backgroundImage: NetworkImage('https://image.shutterstock.com/image-photo/profile-picture-smiling-millennial-asian-600w-1836020740.jpg')
//             ),
//           );
//   }
// }
