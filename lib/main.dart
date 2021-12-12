import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paap_app/app/data/constants.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init(STORAGE_KEYNAME);
  runApp(
    GetMaterialApp.router(
      title: "PAAP",
      // initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
