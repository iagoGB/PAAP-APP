import 'package:get/get.dart';

import 'package:paap_app/app/data/providers/storage_provider.dart';
import 'package:paap_app/app/data/providers/user_provider.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class UsersController extends GetxController with StateMixin {
  final StorageProvider storageProvider;
  final UserProvider userProvider;

  UsersController(
    this.userProvider, {
    required this.storageProvider,
  });

  @override
  void onInit() {
    super.onInit();
    this.getAll();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  logout() {
    this.storageProvider.clear();
    Get.rootDelegate.offAndToNamed(Routes.LOGIN);
  }

  toCreateUser() {
    Get.rootDelegate.toNamed(Routes.CREATE_USER);
  }

  void getAll() async {
    this.userProvider.getAll().then(
      (value) {
        for (var i = 0; i < 20; i++) {
          value.add(value[1]);
        }
        change(value, status: RxStatus.success());
      },
      onError: (err) => change(null, status: RxStatus.error()),
    );
  }

  toUserDetails(id) {
    print('id do usuário $id');
    Get.rootDelegate.toNamed(Routes.USER_DETAILS(id.toString()));
    print('ta executando');
  }
}
