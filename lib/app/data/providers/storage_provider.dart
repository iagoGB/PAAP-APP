import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paap_app/app/data/constants.dart';

class StorageProvider extends GetConnect {
  final storage = GetStorage(STORAGE_KEYNAME);

  @override
  void onInit() {}

  getAuth() {
    return storage.read('auth');
  }

  setAuth(value) async {
    await storage.write('auth', value);
  }

  clear() async {
    await storage.erase();
  }
}
