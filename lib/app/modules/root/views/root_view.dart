import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/root/controllers/root_controller.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, current) {
        return Scaffold(
          // drawer: DrawerWidget(),
          appBar: AppBar(
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            centerTitle: true,
            title: customLogo(),
            actions: [
              customAvatar(),
            ],
            leading: Obx(
              () => controller.hasBackButton.value
                  ? IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        // Navigator.of(context).pop();
                        Get.rootDelegate.toNamed(controller.previousRoute);
                        controller.hideBackButton();
                      },
                    )
                  : Container(),
            ),
          ),
          body: GetRouterOutlet(
            initialRoute: Routes.LOGIN,
            // anchorRoute: '/',
            // filterPages: (afterAnchor) {
            //   return afterAnchor.take(1);
            // },
          ),
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

Widget customAvatar(
    {String urlImage =
        'https://image.shutterstock.com/image-photo/profile-picture-smiling-millennial-asian-600w-1836020740.jpg'}) {
  return Container(
    margin: const EdgeInsets.only(right: 10),
    child: Stack(children: [
      const Center(
          child: CircularProgressIndicator(
        value: 0.5,
        strokeWidth: 1,
      )),
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
