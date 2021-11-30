import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paap_app/app/data/constants.dart';

import '../models/auth_model.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
  }
  

  Future<Auth?> login(email, password) async {
    print('${BASE_URL}/login');
   
      var response = await post('${BASE_URL}/login', {
        "email": email,
        "password": password
      });

      if(response.statusCode == 200){
        return Auth.fromJson(response.body);
      } else {
        Get.defaultDialog(title: "Login", content: Text("Login/Senha não confere."));
        return null;
      }
  }
}
