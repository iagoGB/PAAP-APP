import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/api_provider.dart';

import '../controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(
      () => ApiProvider(),
    );
    Get.lazyPut<RootController>(
      () => RootController(),
    );
  }
}
