import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/api_provider.dart';
import 'package:paap_app/app/data/providers/category_provider.dart';

import '../controllers/edit_category_controller.dart';

class EditCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(
      () => ApiProvider(),
    );
    Get.lazyPut<CategoryProvider>(
      () => CategoryProvider(Get.find()),
    );
    Get.lazyPut<EditCategoryController>(
      () => EditCategoryController(categoryProvider: Get.find()),
    );
  }
}
