import 'package:flutter/material.dart';

SizedBox NoEventsFeedback(String img, String text) => SizedBox(
      width: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(img, width: 250, height: 250, fit: BoxFit.contain),
        Text(
          text,
          style: TextStyle(color: Colors.grey),
        )
      ]),
    );
