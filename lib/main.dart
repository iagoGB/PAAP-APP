import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      theme: CustomTheme().darkTheme,
      darkTheme: CustomTheme().darkTheme,
      themeMode: ThemeMode.system,
      getPages: AppPages.routes,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
    ),
  );
}
