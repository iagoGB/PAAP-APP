import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/user_provider.dart';

class ProfileController extends GetxController with StateMixin {
  final UserProvider userProvider;
  var isEditing = false.obs;
  late TextEditingController emailController;
  late TextEditingController phoneController;

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
      (value) {
        change(value, status: RxStatus.success());
        emailController = TextEditingController(text: value?.email);
        phoneController = TextEditingController(text: value?.telephone);
      },
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
