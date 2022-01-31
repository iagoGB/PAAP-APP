import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:paap_app/app/data/providers/user_provider.dart';

class ChangePasswordController extends GetxController {
  var currentPasswordController = TextEditingController(text: "");
  var confirmPasswordController = TextEditingController(text: "");
  var newPasswordController = TextEditingController(text: "");
  final passwordFormKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  UserProvider userProvider;

  ChangePasswordController({
    required this.userProvider,
  });

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  validateconfirmPassword(String? value) {
    if (value != newPasswordController.text) return 'Senhas não correspondem';
  }

  validateNewPassword(String? value) {
    if (value == "") return 'Informe a nova senha';
    if (value!.length < 4) return 'Senha muito curta';
    return null;
  }

  validatecurrentPassword(String? value) {
    if (value == "") return 'Informe a senha atual';
    return null;
  }

  submit() {
    print('chamou');
    if (this.passwordFormKey.currentState!.validate()) {
      isLoading(true);
      var passwords = {
        'currentPassword': currentPasswordController.text,
        'newPassword': newPasswordController.text
      };
      this.userProvider.changePassword(passwords).then(
            (value) => Get.defaultDialog(
                title: 'Sucesso!', content: Text('Senha atualizada')),
            onError: (err) => Get.defaultDialog(
              title: 'Erro',
              content: Text(err.message ?? 'Erro ao atualizar senha'),
            ),
          );
    }
  }
}
