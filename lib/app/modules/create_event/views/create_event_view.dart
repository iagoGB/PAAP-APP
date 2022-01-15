import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/shared/widgets/custom_text_field.dart';

import '../controllers/create_event_controller.dart';

class CreateEventView extends GetView<CreateEventController> {
  final controller = Get.find<CreateEventController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: Text('CreateEventView'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.rootDelegate.popRoute();
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Get.isDarkMode ? Colors.yellow : Colors.grey[600],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => controller.submit(),
            icon: Icon(
              Icons.check,
              color: Get.isDarkMode ? Colors.yellow : Colors.grey[600],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            mountForm(),
          ],
        ),
      ),
    );
  }

  Form mountForm() {
    return Form(
      key: controller.eventFormKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Obx(
                    () => controller.image.value != null
                        ? previewImage()
                        : pickImageButton(Colors.black),
                  ),
                  Obx(
                    () => Text(
                      controller.imageFeedback.value,
                      style: TextStyle(
                        fontSize: 12,
                        color: Get.isDarkMode ? Colors.yellow : Colors.red[800],
                      ),
                    ),
                  )
                ],
              ),
            ),
            CustomTextFormField(
              validator: controller.titleValidator,
              controller: controller.titleController,
              inputType: TextInputType.text,
              label: 'Título',
              labelColor: Get.theme.primaryColor,
              maxLines: 2,
            ),
            CustomTextFormField(
              validator: controller.dateValidator,
              controller: controller.dateController,
              inputType: TextInputType.datetime,
              label: 'Data',
              labelColor: Get.theme.primaryColor,
            ),
            CustomTextFormField(
              validator: controller.workloadValidator,
              controller: controller.workloadController,
              inputType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              label: 'Carga Horária (Em horas)',
              labelColor: Get.theme.primaryColor,
            ),
            CustomTextFormField(
              validator: controller.speakerValidator,
              controller: controller.speakerController,
              inputType: TextInputType.text,
              label: 'Palestrante',
              labelColor: Get.theme.primaryColor,
            ),
            Obx(
              () => Container(
                margin: EdgeInsets.only(bottom: 10),
                child: DropdownButtonFormField(
                  hint: Text('Selecione a categoria'),
                  onChanged: (value) => print(value.toString()),
                  validator: (value) => controller.validateCategory(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: decorationStyle(
                    label: "Categoria",
                    labelColor: Get.isDarkMode ? Colors.white : Colors.grey,
                  ),
                  items: controller.categories.value
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e.name!),
                          value: e.id,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            CustomTextFormField(
              validator: controller.descriptionValidator,
              controller: controller.descriptionController,
              inputType: TextInputType.text,
              maxLines: 5,
              label: 'Descrição',
              labelColor: Get.theme.primaryColor,
            ),
          ],
        ),
      ),
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
}
