import 'package:flutter/material.dart';

Widget WaitingFeedback() => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 12,
          ),
          // Text(
          //   "Aguarde...",
          //   style: TextStyle(color: Colors.grey.shade700),
          // ),
        ],
      ),
    );
