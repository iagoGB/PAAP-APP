import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_user_controller.dart';

class EditUserView extends GetView<EditUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EditUsersView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'EditUsersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
