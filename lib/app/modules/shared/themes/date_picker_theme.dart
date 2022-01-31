import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paap_app/app/modules/shared/themes/primary_material_color.dart';

ThemeData DatePickerTheme() => ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSwatch(
        backgroundColor:
            Get.isDarkMode ? Colors.yellow : Get.theme.primaryColor,
        primarySwatch: Get.isDarkMode ? Colors.yellow : PrimaryMateriallColor(),
      ),
    );
