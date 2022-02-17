import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paap_app/app/data/providers/storage_provider.dart';
import 'package:paap_app/app/data/providers/user_provider.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  late StorageProvider storageProvider;
  UserProvider userProvider;
  var avatar = "null".obs;
  var currentIndex = 0;

  HomeController({
    required this.storageProvider,
    required this.userProvider,
  });

  @override
  void onInit() {
    super.onInit();
    this.updateAvatar();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  int getCurrentIndex(GetNavConfig? router) {
    final currentLocation = router?.location;
    var currentIndex = 0;
    if (currentLocation?.startsWith(Routes.NOTIFICATIONS) == true) {
      currentIndex = 2;
    }
    if (currentLocation?.startsWith(Routes.PROFILE) == true) {
      currentIndex = 1;
    }
    return currentIndex;
  }

  void changeTabIndex(int index, GetDelegate delegate) {
    switch (index) {
      case 0:
        delegate.toNamed(Routes.HOME);
        break;
      case 1:
        delegate.toNamed(Routes.PROFILE);
        break;
      case 2:
        delegate.toNamed(Routes.NOTIFICATIONS);
        break;
      default:
    }
  }

  void updateAvatar() {
    this.avatar.value = "";
    this.userProvider.getProfile().then((value) {
      this.avatar.value =
          '${value!.avatar}?${DateTime.now().millisecondsSinceEpoch.toString()}';
    }, onError: (err) => print(err));
  }

  goToProfile() {
    Get.rootDelegate.toNamed(Routes.PROFILE);
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

  void logout() async {
    Get.back();
    await this.storageProvider.clear();
    Get.rootDelegate.offNamed(Routes.LOGIN);
  }
}
