import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/shared/widgets/admin_app_bar.dart';
import 'package:paap_app/app/routes/app_pages.dart';

import '../controllers/users_controller.dart';

class UsersView extends GetView<UsersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        iconColor: Get.isDarkMode ? Colors.yellow : Colors.black,
        controller: controller,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.CREATE_EVENT);
              },
              child: Text("Criar"),
            )
          ],
        ),
      ),
    );
  }
}
