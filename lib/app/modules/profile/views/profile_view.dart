import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
          (state) => Obx(
                () => controller.isEditing.value
                    ? mountEditProfile()
                    : mountProfile(state),
              ),
          onError: (err) => Container(
                child: Center(
                  child: Text(
                    'Ocorreu um erro ao carregar os dados do perfil de usuário',
                  ),
                ),
              ),
          onLoading: Center(child: CircularProgressIndicator())),
    );
  }

  Container mountProfile(state) {
    return Container(
      // width: double.infinity,
      height: 200,
      margin: EdgeInsets.only(left: 5, top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mountAvatar(state),
          mountDescription(state),
        ],
      ),
    );
  }

  Container mountAvatar(state) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: CircleAvatar(
        radius: 60,
        backgroundColor: Colors.yellow,
        backgroundImage: NetworkImage(
          'https://fcdocente-teste.s3.sa-east-1.amazonaws.com/usuarios/default-avatar.png',
        ),
      ),
    );
  }

  Flexible mountDescription(state) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              state.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              state.departament,
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              'Carga horária concluída: ${state.workload / 60}h',
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              state.telephone,
              style: TextStyle(fontSize: 12),
            ),
          ),
          ElevatedButton(
            onPressed: () => controller.changeEditing(),
            child: Text(
              'Editar Perfil',
            ),
            style: ElevatedButton.styleFrom(
              primary: Get.theme.primaryColor,
              elevation: 20,
              fixedSize: Size(double.infinity, 20),
            ),
          )
        ],
      ),
    );
  }

  Widget mountEditProfile() {
    return Center(
      child: Container(
        child: Text('Tá no edit'),
      ),
    );
  }
}
