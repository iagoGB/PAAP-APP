import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paap_app/app/data/constants.dart';


class AuthProvider extends GetConnect {
  @override
  void onInit() {
  }
  
  Future<dynamic> login(email, password) async {
      var response = await post('${BASE_URL}/login', {
        "email": email,
        "password": password
      });

      if(response.statusCode == 200){
        return response.body;
      } else {
        Get.defaultDialog(title: "Login", content: Text("Login/Senha não confere."));
        return null;
      }
  }
}
