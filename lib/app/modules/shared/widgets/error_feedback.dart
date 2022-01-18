import 'package:flutter/material.dart';

Center ErrorFeedback(String? error) => Center(
      child: Text(error != null ? error : ''),
    );
