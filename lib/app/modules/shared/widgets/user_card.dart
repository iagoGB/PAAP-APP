import 'package:flutter/material.dart';

Widget UserCard(
    user, Color backgroundTextColor, Color textColor, onTapFunction) {
  return GridTile(
    child: InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => onTapFunction(user.id),
      child: Ink.image(
        image: NetworkImage(user.avatar),
        fit: BoxFit.cover,
      ),
    ),
    footer: Container(
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, backgroundTextColor, Colors.teal],
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      // color: backgroundTextColor,
      alignment: Alignment.center,
      child: Text(
        user.name,
        textAlign: TextAlign.center,
        overflow: TextOverflow.fade,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: textColor,
        ),
      ),
    ),
  );
}
