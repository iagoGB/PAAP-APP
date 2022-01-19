import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/shared/widgets/admin_app_bar.dart';

import '../controllers/edit_user_controller.dart';

class EditUserView extends GetView<EditUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        icon: Icons.arrow_back,
        iconColor: Colors.grey.shade700,
        onTapFunction: controller.toUserDetails,
        actions: [
          IconButton(
            onPressed: () => controller.updateUser(),
            icon: Icon(
              Icons.check,
              color: Get.isDarkMode ? Colors.yellow : Colors.grey.shade700,
            ),
          )
        ],
      ),
      body: Center(
        child: Obx(
          () => Text(
            'EditUsersView is working ${controller.userIdObs.value}',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
