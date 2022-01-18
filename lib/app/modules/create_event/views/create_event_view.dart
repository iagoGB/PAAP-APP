import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/shared/widgets/custom_text_field.dart';
import 'package:paap_app/app/routes/app_pages.dart';

import '../controllers/create_event_controller.dart';

class CreateEventView extends GetView<CreateEventController> {
  final controller = Get.find<CreateEventController>();
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
                        Get.rootDelegate.offAndToNamed(Routes.ADMIN_EVENTS);
                        Get.delete<CreateEventController>();
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
                    onPressed: () => controller.submit(),
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
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    mountForm(context),
                  ],
                ),
              ),
      ),
    );
  }

  Form mountForm(context) {
    return Form(
      key: controller.eventFormKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
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
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    validator: (value) => controller.dateValidator(value!),
                    controller: controller.dateController,
                    onTap: () => controller.displayDatePicker(context),
                    decoration: decorationStyle(
                      label: 'Data',
                      labelColor: Get.theme.primaryColor,
                    ),
                  ),
                ),
                Container(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    validator: (value) => controller.timeValidator(value!),
                    controller: controller.timeController,
                    onTap: () => controller.displayTimePick(context),
                    decoration: decorationStyle(
                      label: 'Horário',
                      labelColor: Get.theme.primaryColor,
                    ),
                  ),
                ),
              ],
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
              validator: controller.locationValidator,
              controller: controller.locationController,
              inputType: TextInputType.text,
              label: 'Localização',
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
                  value: controller.selectedCategory,
                  onChanged: (value) =>
                      controller.selectedCategory = value as int,
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

  InkWell eventImage() {
    return InkWell(
      onTap: () => controller.pickImage(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Obx(
                () => Image(image: NetworkImage(controller.eventImage.value))),
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
}
