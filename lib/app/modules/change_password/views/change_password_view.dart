import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/shared/widgets/custom_text_field.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40),
        child: Form(
          key: controller.passwordFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller.currentPasswordController,
                validator: (value) => controller.validatecurrentPassword(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                decoration: decorationStyle(
                  label: 'Senha atual',
                  labelColor:
                      Get.isDarkMode ? Colors.yellow : Get.theme.primaryColor,
                ),
              ),
              TextFormField(
                controller: controller.newPasswordController,
                validator: (value) => controller.validateNewPassword(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                decoration: decorationStyle(
                  label: 'Nova senha',
                  labelColor:
                      Get.isDarkMode ? Colors.yellow : Get.theme.primaryColor,
                ),
              ),
              TextFormField(
                controller: controller.confirmPasswordController,
                validator: (value) => controller.validateconfirmPassword(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                decoration: decorationStyle(
                  label: 'Confirmar nova senha',
                  labelColor:
                      Get.isDarkMode ? Colors.yellow : Get.theme.primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => controller.backToSettings(),
                      child: Row(
                        children: [
                          Text('Cancelar'),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      style: OutlinedButton.styleFrom(
                        primary: Get.isDarkMode ? Colors.white : Colors.red,
                        side: BorderSide(
                          color: Get.isDarkMode ? Colors.white : Colors.red,
                          width: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () => controller.submit(),
                      child: Row(
                        children: [
                          Text(
                            'Salvar',
                            style: TextStyle(
                              color:
                                  Get.isDarkMode ? Colors.black : Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check,
                            semanticLabel: 'Salvar',
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Get.theme.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
