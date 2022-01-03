import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/users_controller.dart';

class UsersView extends GetView<UsersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UsersView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'UsersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
