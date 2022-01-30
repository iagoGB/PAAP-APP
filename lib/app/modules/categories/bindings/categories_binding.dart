import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/api_provider.dart';
import 'package:paap_app/app/data/providers/category_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';

import '../controllers/categories_controller.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorageProvider>(
      () => StorageProvider(),
    );
    Get.lazyPut<ApiProvider>(
      () => ApiProvider(),
    );
    Get.lazyPut<CategoryProvider>(
      () => CategoryProvider(Get.find()),
    );
    Get.lazyPut<CategoriesController>(
      () => CategoriesController(
        storageProvider: Get.find(),
        categoryProvider: Get.find(),
      ),
    );
  }
}
