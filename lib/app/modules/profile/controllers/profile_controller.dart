import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:paap_app/app/data/providers/user_provider.dart';
import 'package:paap_app/app/modules/home/controllers/home_controller.dart';

class ProfileController extends GetxController with StateMixin {
  final UserProvider userProvider;
  var isEditing = false.obs;
  final profileFormKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late String? currentEmail;
  File? image;
  var hasPreview = false.obs;

  ProfileController(this.userProvider);

  @override
  void onInit() {
    super.onInit();
    this.getProfile();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    this.emailController.dispose();
    this.phoneController.dispose();
  }

  void getProfile() {
    this.userProvider.getProfile().then(
      (value) {
        change(value, status: RxStatus.success());
        emailController = TextEditingController(text: value?.email);
        phoneController = TextEditingController(text: value?.telephone);
        currentEmail = value?.email;
      },
      onError: (e) => change(
        null,
        status: RxStatus.error(),
      ),
    );
  }

  changeEditing() {
    isEditing(!isEditing.value);
  }

  emailValidator(String value) {
    if (!GetUtils.isEmail(value)) return 'Não é um email válido';
  }

  phoneMask() {
    return MaskTextInputFormatter(mask: '(##) # ####-####');
  }

  phoneValidator(String val) {
    if (val.isEmpty) return 'Campo não pode ser vazio';
    if (val.length < 16) return 'Digite um telefone válido';
  }

  submit() {
    if (this.profileFormKey.currentState!.validate()) {
      change(null, status: RxStatus.loading());

      this
          .userProvider
          .updateFromProfile(image, emailController.text, phoneController.text)
          .then(
        (value) {
          Get.defaultDialog(
            title: 'OK',
            content: Text("Dados atualizados com sucesso!"),
          );
          this.getProfile();
          var homeController = Get.find<HomeController>();
          homeController.updateAvatar();
          hasPreview(false);
          changeEditing();
        },
        onError: (err) {
          Get.defaultDialog(
            content: Center(child: Text(err.message)),
          );
          this.getProfile();
          this.image = null;
          hasPreview(false);
          changeEditing();
        },
      );
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      hasPreview(true);
    } on PlatformException catch (e) {
      hasPreview(false);
      Get.defaultDialog(
        content: Text('Erro ao selecionar imagem $e'),
      );
    }
  }
}
