import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/root/controllers/root_controller.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class RootView extends GetView<RootController> {
  var controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, current) {
        return Scaffold(
          // drawer: DrawerWidget(),
          appBar: null,
          body: GetRouterOutlet(
            initialRoute: Routes.LOGIN,
          ),
        );
      },
    );
  }

  // AppBar mountAppBar() {
  //   return AppBar(
  //     backgroundColor: Get.theme.scaffoldBackgroundColor,
  //     centerTitle: true,
  //     title: customLogo(),
  //     actions: [
  //       customAvatar(controller),
  //     ],
  //     leading: Obx(
  //       () => controller.hasBackButton.value
  //           ? IconButton(
  //               icon: Icon(Icons.arrow_back, color: Colors.black),
  //               onPressed: () {
  //                 // Navigator.of(context).pop();
  //                 Get.rootDelegate.toNamed(controller.previousRoute);
  //                 controller.hideBackButton();
  //               },
  //             )
  //           : Container(
  //               margin: EdgeInsets.only(left: 20),
  //               child: IconButton(
  //                 icon: Transform(
  //                   transform: Matrix4.rotationY(math.pi),
  //                   child: Icon(Icons.exit_to_app_outlined),
  //                 ),
  //                 color: Get.isDarkMode ? Colors.yellow : Colors.black,
  //                 onPressed: () {
  //                   controller.logout();
  //                 },
  //               ),
  //             ),
  //     ),
  //   );
  // }
}

// Widget customLogo() {
//   return SizedBox(
//     width: 63,
//     height: 32,
//     child: Image.asset(
//       'assets/images/paap.png',
//       alignment: Alignment.center,
//       width: 63,
//       height: 32,
//     ),
//   );
// }

// Widget customAvatar(controller) {
//   String urlImage =
//       'https://fcdocente-teste.s3.sa-east-1.amazonaws.com/usuarios/default-avatar.png';
//   return Container(
//     margin: EdgeInsets.only(right: 10),
//     child: Stack(children: [
//       Center(
//         child: CircularProgressIndicator(
//           value: 0.5,
//           strokeWidth: 1,
//         ),
//       ),
//       Center(
//         child: CircleAvatar(
//           radius: 20,
//           backgroundColor: Colors.transparent,
//           backgroundImage: NetworkImage(urlImage),
//         ),
//       ),
//     ]),
//   );
// }
