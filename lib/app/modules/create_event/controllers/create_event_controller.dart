import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paap_app/app/data/models/category_model.dart';
import 'package:paap_app/app/data/providers/category_provider.dart';

import 'package:paap_app/app/data/providers/event_provider.dart';

class CreateEventController extends GetxController {
  final EventProvider eventProvider;
  final CategoryProvider categoryProvider;
  final eventFormKey = GlobalKey<FormState>();
  var titleController = TextEditingController(text: "");
  var dateController = TextEditingController(text: "");
  var workloadController = TextEditingController(text: "");
  var speakerController = TextEditingController(text: "");
  var descriptionController = TextEditingController(text: "");
  var categories = <Category>[].obs;
  // var hasPreview = false.obs;
  var imageFeedback = "".obs;
  var image = Rxn<File?>();

  CreateEventController({
    required this.categoryProvider,
    required this.eventProvider,
  });

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    this.getCategories();
  }

  @override
  void onClose() {}

  Future pickImage() async {
    try {
      print('Executou novamente');
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image.value = imageTemporary;
    } on PlatformException catch (e) {
      Get.defaultDialog(
        content: Text('O app não tem permissão para acessar galeria $e'),
      );
    }
  }

  titleValidator(String value) {
    if (value.length < 3) return 'Título muito curto';
    return null;
  }

  dateValidator(String value) {
    if (!GetUtils.isDateTime(value)) return 'Selecione uma data';
  }

  workloadValidator(value) {
    if (value == "" || value == "0") return 'Carga horária não pode ser vazia';
    final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
    if (!validCharacters.hasMatch(value))
      return 'Apenas números são permitidos';
  }

  speakerValidator(String value) {
    if (value.trim().isEmpty) return 'Informe um palestrante';
  }

  validateCategory(value) {
    print(value);
    if (value == null) return 'Selecione uma categoria';
  }

  descriptionValidator(value) {
    // if (value.trim().isEmpty) return 'Insira uma descrição';
    return null;
  }

  void getCategories() async {
    print('Executou get cat');
    await this.categoryProvider.getAll().then(
      (value) {
        print('Deu certo');
        categories.assignAll(value);
        print('categories' + categories.value.toString());
        update();
      },
      onError: (err) => print(err),
    ).whenComplete(() => null);
  }

  submit() {
    var haveImage = image.value != null;
    if (!haveImage) {
      imageFeedback.value = "Selecione uma imagem";
    }
    if (this.eventFormKey.currentState!.validate() && haveImage) {
      this.eventFormKey.currentState!.save();
    }
  }
}
