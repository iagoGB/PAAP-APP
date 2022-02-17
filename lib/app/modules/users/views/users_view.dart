import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:paap_app/app/modules/shared/widgets/admin_app_bar.dart';
import 'package:paap_app/app/modules/shared/widgets/custom_search_bar.dart';
import 'package:paap_app/app/modules/shared/widgets/floating_button.dart';
import 'package:paap_app/app/modules/shared/widgets/no_events_feedback.dart';
import 'package:paap_app/app/modules/shared/widgets/user_card.dart';

import '../controllers/users_controller.dart';

class UsersView extends GetView<UsersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        icon: Icons.exit_to_app_outlined,
        iconColor: Get.isDarkMode ? Colors.yellow : Colors.black,
        onTapFunction: controller.showExitDialog,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchBar(
            query: controller.query,
            onChanged: controller.searchUser,
            labelText: 'Usuarios',
            hintText: 'Nome do usuário',
          ),
          Expanded(
            child: controller.obx(
              (state) => RawScrollbar(
                isAlwaysShown: true,
                thumbColor: const Color.fromRGBO(234, 125, 91, 0.8),
                radius: Radius.circular(20),
                thickness: 8,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: state.length > 10 ? 3 : 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: state.length,
                    itemBuilder: (_, index) => UserCard(
                      state[index],
                      Get.theme.primaryColor,
                      Colors.white,
                      controller.toUserDetails,
                    ),
                  ),
                ),
              ),
              onError: (err) => Center(
                child: Text('Ocorreu um erro ao buscar usuários do sistema'),
              ),
              onEmpty: SingleChildScrollView(
                child: NoEventsFeedback(
                    'assets/images/no_events.png', 'Nenhum usuário encontrado'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          FloatingCreateButton(Get.theme.primaryColor, controller.toCreateUser),
    );
  }
}
