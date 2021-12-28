import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/api_provider.dart';

import '../models/user_model.dart';

class UserProvider extends GetConnect {
  final ApiProvider apiProvider;

  UserProvider(this.apiProvider);

  @override
  void onInit() {}

  Future<User?> getById(int id) async {
    final response = await apiProvider.get('/user/$id');
    return User.fromJson(response.body);
  }

  Future<Response<User>> postUser(User user) async => await post('user', user);
  Future<Response> deleteUser(int id) async => await delete('user/$id');
}
