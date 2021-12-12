import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants.dart';
import '../models/event_model.dart';

class EventProvider extends GetConnect {
  final storage = GetStorage(STORAGE_KEYNAME);
  
  @override
  void onInit() {
    
  }

  Future<List<Event?>> getAllEvents() async {
    final response = await get('${BASE_URL}/event', headers: { 
      'Authorization': storage.read('auth'),
    });
    return response.body.map((e) => Event.fromJson(e)).toList();
  }

  Future<Response<Event>> postEvent(Event event) async =>
      await post('event', event);

  Future<Response> deleteEvent(int id) async => await delete('event/$id');
}
