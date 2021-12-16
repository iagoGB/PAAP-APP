
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paap_app/app/data/constants.dart';
import 'package:paap_app/app/data/models/auth_model.dart';
import 'package:paap_app/app/data/providers/auth_provider.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class LoginController extends GetxController {

  AuthProvider authProvider = Get.find<AuthProvider>();
  final storage = GetStorage(STORAGE_KEYNAME);
  late String email = '';
  late String password = '';
  

  @override
  void onInit() {
    super.onInit();
  }

 login() async {
    await this.authProvider.login( this.email,  this.password).then(
      (auth) => this.storageAndNavigate(auth),
      onError: (err) => {},
    );

   
 }

  storageAndNavigate(dynamic auth) async {
    await storage.write('auth', auth);
    this.navigateToDashboard();
  }

 navigateToDashboard(){
    Get.rootDelegate.toNamed(Routes.HOME);
 }

}
