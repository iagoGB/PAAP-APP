import 'package:get/get.dart';

class RootController extends GetxController {
  var hasBackButton = false.obs;
  String previousRoute = "";

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

  void setBackButton(String previousRoute) {
    this.previousRoute = previousRoute;
    hasBackButton(true);
  }

  void hideBackButton() => hasBackButton(false);
}
