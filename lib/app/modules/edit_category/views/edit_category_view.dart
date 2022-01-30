import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/shared/widgets/admin_app_bar.dart';
import 'package:paap_app/app/modules/shared/widgets/custom_text_field.dart';
import 'package:paap_app/app/modules/shared/widgets/waiting_feedback.dart';

import '../controllers/edit_category_controller.dart';

class EditCategoryView extends GetView<EditCategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        icon: Icons.arrow_back_outlined,
        iconColor: Colors.grey.shade700,
        onTapFunction: controller.toCategoriesList,
        actions: [
          Obx(
            () => controller.isLoading.value
                ? Container()
                : IconButton(
                    onPressed: () => controller.validateForm(),
                    icon: Icon(
                      Icons.check,
                      color:
                          Get.isDarkMode ? Colors.yellow : Colors.grey.shade700,
                    ),
                  ),
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? WaitingFeedback()
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: controller.categoryFormKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        label: 'Nome',
                        labelColor: Get.theme.primaryColor,
                        inputType: TextInputType.name,
                        validator: controller.nameValidator,
                        controller: controller.nameController,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
