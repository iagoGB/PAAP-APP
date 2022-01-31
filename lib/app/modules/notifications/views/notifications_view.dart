import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: customPadding(),
                      child: Text('Tema do app'),
                    ),
                    DropdownButtonHideUnderline(
                      child: Obx(
                        () => Padding(
                          padding: customPadding(),
                          child: DropdownButton(
                            value: controller.currentTheme.value,
                            onChanged: (value) => controller.updateTheme(value),
                            style: TextStyle(
                                fontSize: 12,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.grey.shade500),
                            items: [
                              DropdownMenuItem(
                                child: Text('Claro'),
                                value: 'Claro',
                              ),
                              DropdownMenuItem(
                                child: Text('Escuro'),
                                value: 'Escuro',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () => controller.goToChangePassword(),
                      child: Padding(
                        padding: customPadding(),
                        child: Text('Alterar senha'),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                        onTap: () => controller.goToAbout(),
                        child: Padding(
                          padding: customPadding(),
                          child: Text('Sobre'),
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () => controller.showExitDialog(),
                      child: Padding(
                        padding: customPadding(),
                        child: Text(
                          'Sair',
                          style: TextStyle(
                            color: Get.isDarkMode
                                ? Colors.yellow
                                : Get.theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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

  EdgeInsets customPadding() => const EdgeInsets.symmetric(horizontal: 12.0);
}
