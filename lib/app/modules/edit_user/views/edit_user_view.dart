import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/shared/widgets/admin_app_bar.dart';
import 'package:paap_app/app/modules/shared/widgets/custom_text_field.dart';

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
            onPressed: () => controller.validateForm(),
            icon: Icon(
              Icons.check,
              color: Get.isDarkMode ? Colors.yellow : Colors.grey.shade700,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: mountUserForm(context),
      ),
    );
  }

  mountUserForm(context) {
    return Form(
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
            label: 'Carga Horária',
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
