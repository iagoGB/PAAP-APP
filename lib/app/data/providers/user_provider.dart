import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/api_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';

import '../models/user_model.dart';

class UserProvider extends GetConnect {
  final ApiProvider apiProvider;
  final StorageProvider storageProvider;

  UserProvider(this.apiProvider, this.storageProvider);

  @override
  void onInit() {}

  Future<User?> getById(int id) async {
    final response = await apiProvider.get('/user/$id');
    return User.fromJson(response.body);
  }

  Future<User?> getProfile() async {
    try {
      var id = storageProvider.getAuth()['id'];
      final response = await apiProvider.get('/user/$id');
      return User.fromJson(response.body);
    } catch (e) {}
  }

  Future<Response<User>> postUser(User user) async => await post('user', user);
  Future<Response> deleteUser(int id) async => await delete('user/$id');

  Future<bool> findByEmail(String username) async {
    final response = await apiProvider.get('/user?$username');
    if (response.statusCode == 200) return Future.value(true);
    return Future.value(false);
  }

  create(avatar, user) async {
    final formData = FormData({
      'image': avatar != null
          ? MultipartFile(avatar, filename: '${user['id']}.png')
          : null,
      'user': jsonEncode(user)
    });

    final response = await apiProvider.post('/user', formData);

    if (response.hasError) {
      throw Exception('Erro ao criar usuário! ${response.body['message']}');
    }
  }

  Future<void> update(avatar, user) async {
    final formData = FormData({
      'image': avatar != null
          ? MultipartFile(avatar, filename: '${user['id']}.png')
          : null,
      'user': jsonEncode(user)
    });

    final response =
        await apiProvider.put('/user/update/${user['id']}', formData);

    if (response.hasError) {
      throw Exception('Erro ao atualizar usuário! ${response.body['message']}');
    }
  }

  Future<void> updateFromProfile(
      File? avatar, String email, String phone) async {
    var id = storageProvider.getAuth()['id'];
    var user = {"email": email, "phone": phone};
    final formData = FormData({
      'image':
          avatar != null ? MultipartFile(avatar, filename: '$id.png') : null,
      'user': jsonEncode(user)
    });

    final response = await apiProvider.put('/user/$id', formData);

    if (response.hasError) {
      throw Exception('Erro ao atualizar usuário! ${response.body['message']}');
    }
  }

  Future<List<User?>> getAll() async {
    final response = await apiProvider.get('/user');
    if (response.hasError) throw new Exception('Erro ao buscar usuários');
    return response.body['content'].map<User>((e) => User.fromJson(e)).toList();
  }

  Future<List<User?>> getByName(query) async {
    final response = await apiProvider.get('/user/findBy?query=$query');
    if (response.hasError) throw new Exception('Erro ao buscar usuários');
    return response.body.map<User>((e) => User.fromJson(e)).toList();
  }

  Future<void> changePassword(passwords) async {
    var id = storageProvider.getAuth()['id'];
    var response =
        await this.apiProvider.put('/user/$id/changePassword', passwords);
    if (response.hasError)
      throw Exception(response.body['message'] ?? 'Erro ao atualizar senha');
  }
}
