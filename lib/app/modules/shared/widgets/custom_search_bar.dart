import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paap_app/app/modules/shared/widgets/search_widget.dart';

CustomSearchBar({
  required labelText,
  required query,
  required onChanged,
  required hintText,
}) =>
    Container(
      color: Get.theme.scaffoldBackgroundColor,
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                labelText,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: SearchWidget(
                text: query,
                onChanged: onChanged,
                hintText: hintText,
              ),
            ),
          ],
        ),
      ),
    );
