import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/route_manager.dart';

AppBar AdminAppBar({
  required Color backgroundColor,
  required IconData icon,
  required Color iconColor,
  onTapFunction,
  actions,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    centerTitle: true,
    title: customLogo(),
    leading: Container(
      margin: icon == Icons.exit_to_app_outlined
          ? EdgeInsets.only(left: 18)
          : EdgeInsets.only(right: 18),
      child: Center(
        child: IconButton(
          icon: icon == Icons.exit_to_app_outlined
              ? Transform(
                  transform: Matrix4.rotationY(math.pi),
                  child: Icon(
                    icon,
                    color: iconColor,
                  ),
                )
              : Icon(icon, color: iconColor),
          onPressed: () => onTapFunction(),
        ),
      ),
    ),
    actions: actions,
  );
}

Widget customLogo() {
  return SizedBox(
    width: 70,
    height: 45,
    child: Stack(children: [
      Image.asset(
        'assets/images/paap.png',
        alignment: Alignment.center,
        width: 65,
        height: 40,
      ),
      Positioned(
        bottom: 2,
        right: 0,
        child: Text(
          'ADM',
          style: TextStyle(
            color: Get.isDarkMode ? Colors.yellow : Colors.orange,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    ]),
  );
}
