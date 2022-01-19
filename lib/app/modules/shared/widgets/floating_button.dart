import 'package:flutter/material.dart';

Widget FloatingCreateButton(Color color, onPressedFunction) {
  return Container(
    color: Color(0x00ffffff),
    height: 50,
    width: 150,
    child: ElevatedButton(
      onPressed: () => onPressedFunction(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_sharp),
          Container(margin: EdgeInsets.only(right: 5)),
          Text(
            "Criar",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        primary: color,
      ),
    ),
  );
}
