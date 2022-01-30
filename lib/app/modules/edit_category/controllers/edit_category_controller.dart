import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paap_app/app/data/models/category_model.dart';
import 'package:paap_app/app/data/providers/category_provider.dart';
import 'package:paap_app/app/modules/categories/controllers/categories_controller.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class EditCategoryController extends GetxController {
  final CategoryProvider categoryProvider;
  final categoryFormKey = GlobalKey<FormState>();
  var nameController = TextEditingController(text: "");
  var isLoading = false.obs;

  EditCategoryController({required this.categoryProvider});

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

  nameValidator(String value) {
    if (value.isEmpty) return 'Insira um nome';
    if (value.length < 5) return 'Nome muito curto';
    return null;
  }

  validateForm() {
    if (this.categoryFormKey.currentState!.validate()) {
      isLoading(true);
      this.categoryFormKey.currentState!.save();
      var category = Category(name: nameController.text);
      this.categoryProvider.save(category).then(
        (value) {
          Get.defaultDialog(
            content: Text('Categoria criada com sucesso'),
          );
          Get.rootDelegate.toNamed(Routes.CATEGORIES);
          this.reloadCategories();
        },
        onError: (err) => Get.defaultDialog(
          content: Text(err.message ?? 'Erro ao salvar categoria'),
        ),
      ).whenComplete(() => isLoading(false));
    }
  }

  toCategoriesList() {
    Get.rootDelegate.popRoute();
  }

  void reloadCategories() {
    var categoriesController = Get.find<CategoriesController>();
    categoriesController.getAll();
  }
}
