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
                    ? mountEditProfile(state)
                    : mountProfile(state),
              ),
          onError: (err) => mountErrorFeedback(),
          onLoading: Center(child: CircularProgressIndicator())),
    );
  }

  Widget mountProfile(state) {
    return SingleChildScrollView(
      child: Container(
        // width: double.infinity,
        height: 200,
        margin: EdgeInsets.only(left: 5, top: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mountAvatar(state, 20.0),
            mountDescription(state),
          ],
        ),
      ),
    );
  }

  Container mountAvatar(state, margin) {
    return Container(
      margin: EdgeInsets.only(right: margin),
      child: Obx(
        () => controller.hasPreview.value
            ? CircleAvatar(
                radius: 60,
                backgroundColor: Colors.yellow,
                backgroundImage: FileImage(controller.image!),
              )
            : CircleAvatar(
                radius: 60,
                backgroundColor: Colors.yellow,
                backgroundImage: NetworkImage(state.avatar),
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

  Widget mountEditProfile(state) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => controller.pickImage(),
              child: SizedBox(
                width: 110,
                height: 110,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    mountAvatar(state, 0.0),
                    Icon(Icons.camera_alt_outlined),
                  ],
                ),
              ),
            ),
            mountForm(),
          ],
        ),
      ),
    );
    // return mountAvatar(state);
  }

  Form mountForm() {
    return Form(
      key: controller.profileFormKey,
      child: Column(
        children: [
          TextFormField(
            validator: (val) => controller.emailValidator(val ?? ''),
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: decorationStyle(label: 'Email'),
          ),
          SizedBox(height: 15),
          TextFormField(
            validator: (val) => controller.phoneValidator(val ?? ''),
            controller: controller.phoneController,
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: decorationStyle(label: 'Telefone'),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () => controller.changeEditing(),
                child: Row(
                  children: [
                    Text('Cancelar'),
                    SizedBox(
                      width: 5,
                    ),
                    // Icon(
                    //   Icons.cancel_outlined,
                    //   semanticLabel: 'Cancelar',
                    // ),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                  primary: Colors.red,
                  side: BorderSide(color: Colors.red, width: 1),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () => controller.submit(),
                child: Row(
                  children: [
                    Text('Salvar'),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.check,
                      semanticLabel: 'Salvar',
                    ),
                  ],
                ),
                style:
                    ElevatedButton.styleFrom(primary: Get.theme.primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration decorationStyle({required String label}) {
    return InputDecoration(
      label: Text(label),
      labelStyle: TextStyle(fontSize: 22),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelStyle:
          TextStyle(color: Get.theme.primaryColor, fontSize: 22),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Get.theme.primaryColor, width: 1),
      ),
      errorBorder: null,
    );
  }

  Widget mountErrorFeedback() {
    return Container(
      child: Center(
        child: Text(
          'Ocorreu um erro ao carregar os dados do perfil de usuário',
        ),
      ),
    );
  }
}
