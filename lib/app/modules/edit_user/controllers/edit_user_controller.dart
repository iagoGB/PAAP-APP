import 'package:get/get.dart';

class EditUserController extends GetxController {
  final userIdObs = "".obs;
  final String userId;

  EditUserController(
    this.userId,
  );

  @override
  void onInit() {
    super.onInit();
    this.checkIfisEditing();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void checkIfisEditing() {
    if (!this.userId.isEmpty) {
      userIdObs.value = this.userId;
    }
  }

  updateUser() {}

  toUserDetails() {
    Get.rootDelegate.popRoute();
  }
}
