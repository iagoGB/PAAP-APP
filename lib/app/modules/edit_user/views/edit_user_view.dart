import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/shared/widgets/custom_text_field.dart';
import 'package:paap_app/app/modules/shared/widgets/waiting_feedback.dart';

import '../controllers/edit_user_controller.dart';

class EditUserView extends GetView<EditUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: Obx(
          () => Text(
            controller.appBarTitle.value,
            style: TextStyle(
              color: Get.isDarkMode ? Colors.yellow : Colors.grey[600],
            ),
          ),
        ),
        centerTitle: false,
        leading: Obx(
          () => controller.isLoading.value
              ? Container()
              : Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.toUserDetails();
                      },
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        color:
                            Get.isDarkMode ? Colors.yellow : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
        ),
        actions: [
          Obx(
            () => controller.isLoading.value
                ? Container()
                : IconButton(
                    onPressed: () => controller.validateForm(),
                    icon: Icon(
                      Icons.check,
                      color: Get.isDarkMode ? Colors.yellow : Colors.grey[600],
                    ),
                  ),
          )
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? WaitingFeedback()
            : RawScrollbar(
                isAlwaysShown: true,
                thumbColor: const Color.fromRGBO(234, 125, 91, 0.8),
                radius: Radius.circular(20),
                thickness: 8,
                child: SingleChildScrollView(
                  child: mountUserForm(context),
                ),
              ),
      ),
    );
  }

  mountUserForm(context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: controller.userFormKey,
        child: Column(
          children: [
            Obx(() {
              var haveImageToUpload = controller.image.value != null;
              var isEditing = controller.isEditing.value;
              if (!haveImageToUpload && isEditing) {
                return eventImage();
              } else if (!haveImageToUpload) {
                return pickImageButton(Colors.black);
              } else {
                return previewImage();
              }
            }),
            CustomTextFormField(
              validator: controller.nameValidator,
              controller: controller.nameController,
              inputType: TextInputType.text,
              label: 'Nome',
              labelColor: Get.theme.primaryColor,
              maxLines: 2,
            ),
            TextFormField(
              inputFormatters: [controller.phoneMask()],
              validator: (s) => controller.phoneValidator(s),
              controller: controller.phoneController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              decoration: decorationStyle(
                label: 'Telefone',
                labelColor: Get.theme.primaryColor,
              ),
            ),
            CustomTextFormField(
              validator: controller.emailValidator,
              controller: controller.emailController,
              inputType: TextInputType.emailAddress,
              label: 'E-mail',
              labelColor: Get.theme.primaryColor,
              maxLines: 2,
            ),
            TextFormField(
              inputFormatters: [controller.siapeMask()],
              validator: (value) => controller.siapeValidator(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller.siapeController,
              keyboardType: TextInputType.number,
              decoration: decorationStyle(
                label: "SIAPE",
                labelColor: Get.theme.primaryColor,
              ),
            ),
            TextFormField(
              inputFormatters: [controller.cpfMask()],
              validator: (value) => controller.cpfValidator(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller.cpfController,
              keyboardType: TextInputType.number,
              decoration: decorationStyle(
                label: "CPF",
                labelColor: Get.theme.primaryColor,
              ),
            ),
            CustomTextFormField(
              initialValue: "0",
              validator: controller.workloadValidator,
              controller: controller.workloadController,
              inputType: TextInputType.number,
              label: 'Carga Hor??ria',
              labelColor: Get.theme.primaryColor,
            ),
            CustomTextFormField(
              validator: controller.departamentValidator,
              controller: controller.departamentController,
              inputType: TextInputType.text,
              label: 'Departamento',
              labelColor: Get.theme.primaryColor,
              maxLines: 2,
            ),
            TextFormField(
              focusNode: controller.dateFocus,
              validator: (value) => controller.dateValidator(value!),
              controller: controller.dateController,
              onTap: () => controller.displayDatePicker(context),
              decoration: decorationStyle(
                label: 'Data de Ingresso',
                labelColor: Get.theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell eventImage() {
    return InkWell(
      onTap: () => controller.pickImage(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Obx(
                () => Image(image: NetworkImage(controller.userImage.value))),
          ),
          pickImageButton(Colors.white),
        ],
      ),
    );
  }

  IconButton pickImageButton(Color color) {
    return IconButton(
      icon: Icon(
        Icons.photo_camera,
        size: 40,
        color: color,
      ),
      onPressed: () => controller.pickImage(),
    );
  }

  InkWell previewImage() {
    return InkWell(
      onTap: () => controller.pickImage(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(image: FileImage(controller.image.value!))),
          pickImageButton(Colors.white),
        ],
      ),
    );
  }
}
