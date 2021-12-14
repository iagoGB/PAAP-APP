import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paap_app/app/data/models/auth_model.dart';

import '../constants.dart';
import '../models/event_model.dart';

class EventProvider extends GetConnect {
  final storage = GetStorage(STORAGE_KEYNAME);
  
  @override
  void onInit() {
    
  }

  Future<List<Event?>> getOpens() async {
    Auth auth = storage.read('auth');
    print('token ${auth.token}');
    final response = await get('${BASE_URL}/event/open', headers: { 
      'Authorization': auth.token!,
    });
    if(response.hasError) {
      print('Deu erro ao requisitar eventos');
    }
    return response.body.map<Event>((e) => Event.fromJson(e)).toList();
  }

  Future<Response<Event>> postEvent(Event event) async =>
      await post('event', event);

  Future<Response> deleteEvent(int id) async => await delete('event/$id');
}
