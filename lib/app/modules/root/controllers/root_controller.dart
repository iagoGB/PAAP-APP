import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';

import 'package:paap_app/app/data/providers/user_provider.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class RootController extends GetxController {
  late UserProvider userProvider;
  late StorageProvider storageProvider;
  var hasBackButton = false.obs;
  var urlAvatar = "".obs;
  String previousRoute = "";

  RootController({required this.userProvider, required this.storageProvider});

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
  void onClose() {}

  void setBackButton(String previousRoute) {
    this.previousRoute = previousRoute;
    hasBackButton(true);
  }

  void hideBackButton() => hasBackButton(false);

  getProfile() async {
    print("-----------------------------Executou root controller");
    await this.userProvider.getProfile().then(
          (user) => urlAvatar.value = user?.avatar ?? "",
        );
  }

  void updateAvatar() async {
    print("-----------------------------Executou update controller");
    await this.getProfile();
    this.urlAvatar.refresh();
  }

  void logout() async {
    await this.storageProvider.clear();
    Get.rootDelegate.offNamed(Routes.LOGIN);
  }
}
