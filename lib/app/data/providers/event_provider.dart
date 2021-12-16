import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:paap_app/app/data/providers/api_provider.dart';

import '../models/event_model.dart';

class EventProvider extends GetConnect {
  
  final ApiProvider apiProvider;

  EventProvider(
    this.apiProvider,
  );

  @override
  void onInit() {
  }

  Future<List<Event?>> getOpens() async {
    final response = await apiProvider.get('/event/open');

    if(response.hasError) {
      throw new Exception('Erro ao buscar eventos abertos');
    }
    return response.body.map<Event>((e) => Event.fromJson(e)).toList();
  }

  Future<Response<Event>> postEvent(Event event) async =>
      await post('event', event);

  Future<Response> deleteEvent(int id) async => await delete('event/$id');
}
