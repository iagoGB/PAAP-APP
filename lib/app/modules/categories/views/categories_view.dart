import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/shared/widgets/admin_app_bar.dart';
import 'package:paap_app/app/modules/shared/widgets/floating_button.dart';

import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          icon: Icons.exit_to_app_outlined,
          iconColor: Get.isDarkMode ? Colors.yellow : Colors.black,
          onTapFunction: controller.logout),
      body: controller.obx(
        (state) => ListView.builder(
          itemCount: state.length,
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Card(
              child: ListTile(
                title: Text(
                  state[index].name,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingCreateButton(
          Get.theme.primaryColor, controller.toCreateCategory),
    );
  }
}
