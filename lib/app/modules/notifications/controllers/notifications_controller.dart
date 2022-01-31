import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paap_app/app/modules/home/controllers/home_controller.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class NotificationsController extends GetxController {
  var currentTheme = "".obs;
  @override
  void onInit() {
    super.onInit();
    currentTheme.value = Get.isDarkMode ? 'Escuro' : 'Claro';
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  logout() {
    Get.back();
    var homeController = Get.find<HomeController>();
    homeController.logout();
  }

  updateTheme(value) {
    if (value == 'Claro') {
      Get.changeThemeMode(ThemeMode.light);
      this.currentTheme.value = 'Claro';
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      this.currentTheme.value = 'Escuro';
    }
    this.update();
  }

  showExitDialog() {
    Get.defaultDialog(
      title: "Alerta",
      contentPadding: EdgeInsets.all(16),
      titlePadding: EdgeInsets.all(8),
      content: Text("Deseja realmente sair do app?"),
      radius: 20,
      textCancel: "Cancelar",
      buttonColor: Get.isDarkMode ? Colors.yellow : Get.theme.primaryColor,
      cancelTextColor: Get.isDarkMode ? Colors.yellow : Get.theme.primaryColor,
      textConfirm: "Confirmar",
      confirmTextColor: Get.isDarkMode ? Colors.black : Colors.white,
      onCancel: () => Get.back(),
      onConfirm: () => this.logout(),
    );
  }

  goToAbout() {
    Get.rootDelegate.toNamed(Routes.ABOUT);
  }

  goToChangePassword() {
    Get.rootDelegate.toNamed(Routes.CHANGE_PASSWORD);
  }
}
