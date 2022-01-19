import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_details_controller.dart';

class UserDetailsView extends GetView<UserDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserDetailsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'UserDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
