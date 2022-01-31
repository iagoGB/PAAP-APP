import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paap_app/app/modules/shared/widgets/admin_app_bar.dart';

import '../controllers/user_details_controller.dart';

class UserDetailsView extends GetView<UserDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        icon: Icons.arrow_back,
        iconColor: Colors.grey.shade700,
        onTapFunction: controller.toUsersList,
        actions: [
          IconButton(
            onPressed: () => controller.editUser(controller.userId),
            icon: Icon(
              Icons.edit,
              color: Get.isDarkMode ? Colors.yellow : Colors.grey.shade700,
            ),
          )
        ],
      ),
      body: controller.obx(
        (user) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.yellow,
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                  ],
                ),
                Text(
                  'Nome',
                  style: labelStyle(),
                ),
                spacing(),
                Text(user.name),
                spacing(),
                Text(
                  'CPF',
                  style: labelStyle(),
                ),
                spacing(),
                Text(user.cpf),
                spacing(),
                Text(
                  'SIAPE',
                  style: labelStyle(),
                ),
                spacing(),
                Text(user.siape ?? ''),
                spacing(),
                Text(
                  'Telefone',
                  style: labelStyle(),
                ),
                spacing(),
                Text(user.telephone),
                spacing(),
                Text(
                  'Email',
                  style: labelStyle(),
                ),
                spacing(),
                Text(user.email),
                spacing(),
                Text(
                  'Carga horária',
                  style: labelStyle(),
                ),
                spacing(),
                Text('${user.workload.toString()} h'),
                spacing(),
                Text(
                  'Departamento',
                  style: labelStyle(),
                ),
                spacing(),
                Text(user.departament),
                spacing(),
                Text(
                  'Data de ingresso',
                  style: labelStyle(),
                ),
                spacing(),
                Text(DateFormat("dd/MM/yyyy", "pt-BR").format(user.entryDate)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container spacing() => Container(
        margin: EdgeInsets.symmetric(vertical: 8),
      );
  TextStyle labelStyle() => TextStyle(
        color: Colors.grey[500],
        fontSize: 16,
      );
}
