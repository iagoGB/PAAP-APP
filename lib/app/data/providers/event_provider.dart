import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:paap_app/app/data/constants.dart';
import 'package:path/path.dart';

import 'package:get/get.dart';

import 'package:paap_app/app/data/providers/api_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart'
    as getConnect;
import 'package:get/get_connect/http/src/multipart/form_data.dart'
    as getConnect;

import '../models/event_model.dart';

class EventProvider extends GetConnect {
  final ApiProvider apiProvider;
  final StorageProvider storageProvider;

  EventProvider(
    this.apiProvider,
    this.storageProvider,
  );

  @override
  void onInit() {}

  Future<List<Event?>> getOpens() async {
    final response = await apiProvider.get('/event/open');

    if (response.hasError) {
      throw new Exception('Erro ao buscar eventos abertos');
    }
    return response.body
        .map<Event>((e) => Event.fromJson(e))
        .toList()
        .reversed
        .toList();
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
    return response.body
        .map<Event>((e) => Event.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  Future<void> postEvent(image, event) async {
    final formData = getConnect.FormData({
      'image':
          getConnect.MultipartFile(image, filename: '${basename(image.path)}'),
      'event': jsonEncode(event)
    });
    var response = await apiProvider.post('/event', formData);
    if (response.hasError) {
      throw new Exception('Erro ao criar novo evento');
    }
  }

  updateEvent(image, event) async {
    final formData = getConnect.FormData({
      'image': image != null
          ? getConnect.MultipartFile(image, filename: '${basename(image.path)}')
          : null,
      'event': jsonEncode(event)
    });
    var response = await apiProvider.put('/event', formData);
    if (response.hasError) {
      throw new Exception('Erro ao criar novo evento ${response.bodyString}');
    }
  }

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
        throw new Exception(response.body['error']);
      else
        throw new Exception('Erro ao tentar registrar presença');
    }
  }

  Future<List<Event?>> getAll() async {
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

  Future<File?> downloadCertificate(event, user) async {
    try {
      final appStorage = await getExternalStorageDirectory();
      print('app Storage $appStorage');
      if (appStorage == null)
        throw new Exception('Permissão de acesso ao dispositivo negada!');
      var file = File(
          '${appStorage.path}/${event.title.replaceAll(' ', '')}_${user.name.replaceAll(' ', '')}.pdf');
      var response = await Dio().post(
        '${BASE_URL}/event/certification?eventID=${event.id}&userID=${user.id}',
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } on Exception catch (e) {
      print(e);
      throw new Exception(e);
    }
  }

  Future<List<Event?>> getByQuery(String query) async {
    final response = await apiProvider.get('/event/findBy?query=$query');
    if (response.hasError) {
      throw new Exception('Erro ao buscar eventos');
    }
    return response.body
        .map<Event>((e) => Event.fromJson(e))
        .toList()
        .reversed
        .toList();
  }
}
