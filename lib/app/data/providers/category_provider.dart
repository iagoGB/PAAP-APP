import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/api_provider.dart';

import '../models/category_model.dart';

class CategoryProvider extends GetConnect {
  final ApiProvider apiProvider;

  CategoryProvider(this.apiProvider);

  @override
  void onInit() {}

  Future<List<Category>> getAll() async {
    final response = await apiProvider.get('/category');
    if (response.hasError) throw Exception('Erro ao consultar categorias');
    return response.body.map<Category>((e) => Category.fromJson(e)).toList();
  }

  Future<Category?> getCategory(int id) async {
    final response = await get('category/$id');
    return response.body;
  }

  Future<void> save(Category category) async {
    var response = await this.apiProvider.post('/category', category.toJson());
    if (response.hasError) throw Exception('Erro ao salvar categoria');
  }
}
