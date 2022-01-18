import 'dart:convert';
import 'package:path/path.dart';

import 'package:get/get.dart';

import 'package:paap_app/app/data/providers/api_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';

import '../models/event_model.dart';

class EventProvider extends GetConnect {
  ApiProvider apiProvider;
  final StorageProvider storageProvider;

  EventProvider(
    this.apiProvider,
    this.storageProvider,
  );

  @override
  void onInit() {
    this.apiProvider = Get.find<ApiProvider>();
  }

  Future<List<Event?>> getOpens() async {
    final response = await apiProvider.get('/event/open');

    if (response.hasError) {
      throw new Exception('Erro ao buscar eventos abertos');
    }
    return response.body.map<Event>((e) => Event.fromJson(e)).toList();
  }

  Future<List<Event?>> getEnrolleds() async {
    var auth = storageProvider.getAuth();
    final response =
        await apiProvider.get('/event/enrolled?userID=${auth['id']}');
    if (response.hasError) {
      throw new Exception('Erro ao buscar eventos que você se inscreveu');
    }
    return response.body.map<Event>((e) => Event.fromJson(e)).toList();
  }

  Future<List<Event?>> getHistoric() async {
    var auth = storageProvider.getAuth();
    final response =
        await apiProvider.get('/event/historic?userID=${auth['id']}');
    if (response.hasError) {
      throw new Exception('Erro ao buscar eventos que você participou');
    }
    return response.body.map<Event>((e) => Event.fromJson(e)).toList();
  }

  Future<void> postEvent(image, event) async {
    final formData = FormData({
      'image': MultipartFile(image, filename: '${basename(image.path)}'),
      'event': jsonEncode(event)
    });
    var response = await apiProvider.post('/event', formData);
    if (response.hasError) {
      throw new Exception('Erro ao criar novo evento');
    }
  }

  updateEvent(image, event) async {
    final formData = FormData({
      'image': image != null
          ? MultipartFile(image, filename: '${basename(image.path)}')
          : null,
      'event': jsonEncode(event)
    });
    var response = await apiProvider.put('/event', formData);
    if (response.hasError) {
      throw new Exception('Erro ao criar novo evento ${response.bodyString}');
    }
  }

  Future<Response> deleteEvent(int id) async => await delete('event/$id');

  Future<Event> findByID(id) async {
    final response = await apiProvider.get('/event/$id');
    if (response.hasError) {
      throw new Exception('Erro ao consultar detalhe do evento');
    }
    return Event.fromJson(response.body);
  }

  Future<void> subscribe(eventId, userId) async {
    final response = await apiProvider.post(
        '/event/$eventId/subscribe?userID=$userId', null);
    if (response.hasError) {
      throw new Exception('Erro ao se inscrever no evento');
    }
  }

  Future<void> unsubscribe(String eventId, userId) async {
    final response = await apiProvider
        .delete('/event/$eventId/remove-subscribe?userID=$userId');
    if (response.hasError) {
      throw new Exception('Erro ao cancelar inscrição no evento');
    }
  }

  Future<void> registerPresence(String eventId, String code) async {
    var auth = storageProvider.getAuth();
    final response = await apiProvider.put('/event/$eventId/register-presence',
        {'keyword': code, 'userID': auth['id']});
    if (response.hasError) {
      if (response.statusCode == 400)
        throw new Exception(response.body['erro']);
      else
        throw new Exception('Erro ao tentar registrar presença');
    }
  }

  Future<List<Event?>> getAll() async {
    var auth = storageProvider.getAuth();
    final response = await apiProvider.get('/event');
    if (response.hasError) {
      print('error api ${response.bodyString}');
      throw new Exception('Erro ao buscar eventos');
    }
    return response.body['content']
        .map<Event>((e) => Event.fromJson(e))
        .toList()
        .reversed
        .toList();
  }
}
