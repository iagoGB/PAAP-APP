import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paap_app/app/modules/search/controllers/search_controller.dart';



class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'SearchView is working ${controller.count}}',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
