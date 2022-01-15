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
    print(response.body);
    if (response.hasError) throw Exception('Erro ao consultar categorias');
    response.printInfo();
    print('Deu certo consultar categorias');
    return response.body.map<Category>((e) => Category.fromJson(e)).toList();
  }

  Future<Category?> getCategory(int id) async {
    final response = await get('category/$id');
    return response.body;
  }

  Future<Response<Category>> postCategory(Category category) async =>
      await post('category', category);

  Future<Response> deleteCategory(int id) async => await delete('category/$id');
}
