import 'package:get/get.dart';

class UserDetailsController extends GetxController {
  final String userId;

  UserDetailsController(this.userId);

  @override
  void onInit() {
    super.onInit();
    print('user ID $userId');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
