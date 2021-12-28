import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.size.width,
          height: Get.size.height,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/paap.png'),
                Text(
                  "Móvel",
                  style: TextStyle(
                      color: Get.theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                customTextField(
                  label: "Login",
                  hintLabel: "Insira seu email",
                  textInputType: TextInputType.emailAddress,
                  obscureText: false,
                  onChange: (value) {
                    controller.email = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                customTextField(
                    label: "Senha",
                    hintLabel: "Insira sua senha",
                    textInputType: TextInputType.text,
                    obscureText: true,
                    onChange: (value) {
                      controller.password = value;
                    }),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Get.theme.primaryColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        minimumSize: const Size(double.infinity, 50)),
                    onPressed: () {
                      controller.login();
                    },
                    child: Text(
                      "Acessar",
                      style: TextStyle(
                        color: Get.theme.secondaryHeaderColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextField customTextField(
    {required label,
    required hintLabel,
    required onChange,
    required textInputType,
    required obscureText}) {
  return TextField(
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.only(top: 15, bottom: 15),
      fillColor: Get.theme.hintColor,
      hintText: hintLabel,
      hintStyle: const TextStyle(
        fontSize: 20,
        height: 1.5,
        fontWeight: FontWeight.w400,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelText: label,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.grey,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Get.theme.primaryColor,
        ),
      ),
      labelStyle: TextStyle(
        color: Get.theme.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    ),
    onChanged: onChange,
    keyboardType: textInputType,
    obscureText: obscureText,
  );
}
