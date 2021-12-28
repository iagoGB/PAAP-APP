import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paap_app/app/data/constants.dart';
import 'package:paap_app/app/themes/themes.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init(STORAGE_KEYNAME);
  runApp(
    GetMaterialApp.router(
      title: "PAAP",
      theme: CustomTheme().lightTheme,
      darkTheme: CustomTheme().darkTheme,
      themeMode: ThemeMode.system,
      getPages: AppPages.routes,
    ),
  );
}
