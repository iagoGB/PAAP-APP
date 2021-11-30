import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paap_app/app/data/constants.dart';
import 'package:paap_app/app/data/providers/auth_provider.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  AuthProvider authProvider = Get.find<AuthProvider>();
  late String email;
  late String password;
  final storage = GetStorage(STORAGE_KEYNAME);

  @override
  void onInit() {
    super.onInit();
  }

 login() async {
    await this.authProvider.login( this.email,  this.password).then((auth) {
      storage.write('auth', auth);
      storage.read('auth');
      this.navigateToDashboard();
    });
 }

 navigateToDashboard(){
   Get.offNamed(Routes.HOME);
 }

}
