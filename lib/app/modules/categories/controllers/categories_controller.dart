import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/category_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class CategoriesController extends GetxController with StateMixin {
  final StorageProvider storageProvider;
  final CategoryProvider categoryProvider;

  CategoriesController({
    required this.storageProvider,
    required this.categoryProvider,
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

  void getAll() {
    this.categoryProvider.getAll().then(
        (categories) => change(categories, status: RxStatus.success()),
        onError: (err) => change(err, status: RxStatus.error()));
  }

  toCreateCategory() {
    Get.rootDelegate.toNamed(Routes.CREATE_CATEGORY);
  }

  logout() {
    this.storageProvider.clear();
    Get.rootDelegate.offNamed(Routes.LOGIN);
  }
}
