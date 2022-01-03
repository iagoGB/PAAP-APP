import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/auth_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  AuthProvider authProvider = Get.find<AuthProvider>();
  StorageProvider storageProvider = Get.find<StorageProvider>();
  late String email = '';
  late String password = '';
  var isLogging = false.obs;

  @override
  void onInit() {
    super.onInit();
    this.checkIfIsLoggedIn();
  }

  login() async {
    isLogging(true);
    await this
        .authProvider
        .login(this.email, this.password)
        .then(
          (auth) => this.storageAndNavigate(auth),
          onError: (err) => {},
        )
        .whenComplete(() => isLogging(false));
  }

  storageAndNavigate(dynamic auth) async {
    storageProvider.setAuth(auth);

    if (auth?['role'] == 'ADMIN') Get.rootDelegate.toNamed(Routes.ADMIN);
    if (auth?['role'] == 'USER') Get.rootDelegate.toNamed(Routes.HOME);
  }

  void checkIfIsLoggedIn() {
    print("Executou checkifislogeed in");
    var auth = storageProvider.getAuth();

    if (auth?['role'] == 'ADMIN') Get.rootDelegate.toNamed(Routes.ADMIN);
    if (auth?['role'] == 'USER') Get.rootDelegate.toNamed(Routes.HOME);
  }
}
