import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paap_app/app/data/constants.dart';

class ApiProvider extends GetConnect {
  final storage = GetStorage(STORAGE_KEYNAME);

  @override
  void onInit() {

    // add your local storage here to load for every request
    var auth = storage.read('auth');
    //1.base_url 
    httpClient.baseUrl = BASE_URL;
    httpClient.addAuthenticator<dynamic>((request) async {
      request.headers['Authorization'] = "${auth['token']}";
      return request;
    });
    super.onInit();
  }
}