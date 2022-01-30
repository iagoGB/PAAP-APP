import 'package:get/get.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class AdminController extends GetxController {
  var currentIndex = 0;
  var isHidden = false.obs;

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
    if (currentLocation?.startsWith(Routes.ADMIN_EVENTS) == true) {
      currentIndex = 1;
    }
    if (currentLocation?.startsWith(Routes.CATEGORIES) == true) {
      currentIndex = 2;
    }
    return currentIndex;
  }

  void changeTabIndex(int index, GetDelegate delegate) {
    switch (index) {
      case 0:
        delegate.toNamed(Routes.USERS);
        break;
      case 1:
        delegate.toNamed(Routes.ADMIN_EVENTS);
        break;
      case 2:
        delegate.toNamed(Routes.CATEGORIES);
        break;
      default:
    }
  }

  changeIsHidden(bool value) {
    isHidden(value);
  }

  logout() {}
}
