import 'package:get/get.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  var currentIndex = 0;

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

  int getCurrentIndex(GetNavConfig? router) {
    final currentLocation = router?.location;
    var currentIndex = 0;
    if (currentLocation?.startsWith(Routes.NOTIFICATIONS) == true) {
      currentIndex = 2;
    }
    if (currentLocation?.startsWith(Routes.PROFILE) == true) {
      currentIndex = 1;
    }
    return currentIndex;
  }

  void changeTabIndex(int index, GetDelegate delegate) {
    switch (index) {
      case 0:
        delegate.toNamed(Routes.HOME);
        break;
      case 1:
        delegate.toNamed(Routes.PROFILE);
        break;
      case 2:
        delegate.toNamed(Routes.NOTIFICATIONS);
        break;
      default:
    }
  }

  void logout() {}
}
