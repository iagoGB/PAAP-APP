import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget EventCard({
  required event,
  required onTapFunction,
  required Color textColor,
}) =>
    Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          margin: EdgeInsets.all(5),
          elevation: 3,
          child: InkWell(
            onTap: () => onTapFunction(event.id),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat("d 'de' MMM '-' HH:mm", "pt-BR")
                              .format(event.dateTime)
                              .toUpperCase(),
                          style: TextStyle(
                            color: textColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          event.title,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(bottom: 20),
                        ),
                        Text(
                          event.category.name,
                          style: TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.grey,
                    margin: EdgeInsets.only(right: 12, left: 12),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Ink.image(
                          width: 80,
                          height: 80,
                          image: NetworkImage(event.picture != 'default.png'
                              ? event.picture
                              : 'https://fcdocente-teste.s3.sa-east-1.amazonaws.com/eventos/paap.png'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
