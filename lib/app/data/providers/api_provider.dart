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
    httpClient.timeout = Duration(seconds: 20);
    httpClient.addRequestModifier<dynamic>((request) {
      // request.headers['Authorization'] = "${auth['token']}";
      // print(request.headers);
      return request;
    });
    // super.onInit();
  }
}
