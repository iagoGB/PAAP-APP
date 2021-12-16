import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paap_app/app/data/constants.dart';
import 'package:paap_app/app/data/models/auth_model.dart';

import '../routes/app_pages.dart';

class EnsureAuthMiddleware extends GetMiddleware {
  final storage = GetStorage(STORAGE_KEYNAME);
  
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    // you can do whatever you want here
    // but it's preferable to make this method fast
    // await Future.delayed(Duration(milliseconds: 500));
  
    if (storage.read('auth') == null) {
      final newRoute = Routes.LOGIN;
      return GetNavConfig.fromRoute(newRoute);
    }
    return await super.redirectDelegate(route);
  }
}

class EnsureNotAuthedMiddleware extends GetMiddleware {
  final storage = GetStorage(STORAGE_KEYNAME);
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    var auth = storage.read('auth');
    if (auth != null) {
      //NEVER navigate to auth screen, when user is already authed
      return null;

      //OR redirect user to another scree
      // return GetNavConfig.fromRoute(Routes.PROFILE);
    }
    return await super.redirectDelegate(route);
  }
}