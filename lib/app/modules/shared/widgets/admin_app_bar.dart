import 'package:flutter/material.dart';
import 'dart:math' as math;

AppBar AdminAppBar({
  required Color backgroundColor,
  required Color iconColor,
  controller,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    centerTitle: true,
    title: customLogo(),
    leading: Container(
      margin: const EdgeInsets.only(left: 15),
      child: Center(
        child: IconButton(
          icon: Transform(
            transform: Matrix4.rotationY(math.pi),
            child: Icon(
              Icons.exit_to_app_outlined,
              color: iconColor,
            ),
          ),
          onPressed: () {
            controller.logout();
          },
        ),
      ),
    ),
  );
}

Widget customLogo() {
  return SizedBox(
    width: 63,
    height: 32,
    child: Image.asset(
      'assets/images/paap.png',
      alignment: Alignment.center,
      width: 63,
      height: 32,
    ),
  );
}
