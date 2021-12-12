import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        //This router outlet handles the appbar and the bottom navigation bar
        final currentLocation = currentRoute?.location;
        var currentIndex = 0;
        if (currentLocation?.startsWith(Routes.NOTIFICATIONS) == true) {
          currentIndex = 2;
        }
        if (currentLocation?.startsWith(Routes.SEARCH) == true) {
          currentIndex = 1;
        }
        return Scaffold(
          body: GetRouterOutlet(
            initialRoute: Routes.EVENTS,
            // anchorRoute: Routes.HOME,
            key: Get.nestedKey(Routes.HOME),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              switch (value) {
                case 0:
                  delegate.toNamed(Routes.HOME);
                  break;
                case 1:
                  delegate.toNamed(Routes.SEARCH);
                  break;
                case 2:
                  delegate.toNamed(Routes.NOTIFICATIONS);
                  break;
                default:
              }
            },
            items: [
              // _Paths.HOME + [Empty]
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              // _Paths.HOME + Routes.PROFILE
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded),
                label: 'Profile',
              ),
              // _Paths.HOME + _Paths.PRODUCTS
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded),
                label: 'Products',
              ),
            ],
          ),
        );
      },
    );
  }
}
    

//   BottomNavigationBar customBottomNavBar(controller) {
//     return BottomNavigationBar(
//       showUnselectedLabels: false,
//       currentIndex: controller.currentIndex,
//       onTap: (index) => controller.changeTabIndex(index),
//       selectedItemColor: const Color.fromRGBO(234, 125, 91, 0.8),
//       items: const [
//       BottomNavigationBarItem(
//         icon: Icon(Icons.home),
//         label:'Home'
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.search),
//         label:'Pesquisar'
//       ),
//        BottomNavigationBarItem(
//         icon: Icon(Icons.notifications),
//         label:'Notificações'
//       ),

//     ],);
//   }

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
