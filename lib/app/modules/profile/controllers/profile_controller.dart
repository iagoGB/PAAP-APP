import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/user_provider.dart';

class ProfileController extends GetxController with StateMixin {
  final UserProvider userProvider;
  var isEditing = false.obs;

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
  void onClose() {}

  void getProfile() {
    this.userProvider.getProfile().then(
          (value) => change(
            value,
            status: RxStatus.success(),
          ),
          onError: (e) => change(
            null,
            status: RxStatus.error(),
          ),
        );
  }

  changeEditing() {
    isEditing(!isEditing.value);
  }
}
