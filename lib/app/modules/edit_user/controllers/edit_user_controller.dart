import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:paap_app/app/data/models/user_model.dart';
import 'package:paap_app/app/data/providers/user_provider.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class EditUserController extends GetxController {
  final UserProvider userProvider;
  final userFormKey = GlobalKey<FormState>();
  var nameController = TextEditingController(text: "");
  var phoneController = TextEditingController(text: "");
  var emailController = TextEditingController(text: "");
  var cpfController = TextEditingController(text: "");
  var workloadController = TextEditingController(text: "");
  var departamentController = TextEditingController(text: "");
  var dateController = TextEditingController(text: "");

  final String userId;

  var image = Rxn<File?>();
  var userImage = "".obs;
  var isEditing = false.obs;
  var isLoading = false.obs;

  EditUserController(
    this.userId,
    this.userProvider,
  );

  @override
  void onInit() {
    super.onInit();
    this.checkIfisEditing();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void checkIfisEditing() {
    if (!this.userId.isEmpty) {
      this.isLoading(true);
      this.isEditing(true);
      this.userProvider.getById(int.parse(this.userId)).then(
        (value) {
          this.setForm(value!);
        },
        onError: (err) =>
            Get.defaultDialog(content: Text('Erro ao buscar dados do usuário')),
      ).whenComplete(() => this.isLoading(false));
    }
  }

  cpfMask() {
    return MaskTextInputFormatter(mask: '###.###.###-##');
  }

  phoneMask() {
    return MaskTextInputFormatter(mask: '(##) # ####-####');
  }

  nameValidator(value) {
    if (value.isEmpty) return 'Insira um nome';
    return null;
  }

  phoneValidator(value) {
    if (value.isEmpty) return 'Campo vazio';
    if (value.length < 16) return 'Digite um telefone válido';
  }

  emailValidator(value) {
    if (!GetUtils.isEmail(value)) return 'Digite um e-mail válido';
    return null;
  }

  cpfValidator(value) {
    if (value.length < 14) return 'Digite um cpf válido';
    return null;
  }

  workloadValidator(value) {
    if (value.isEmpty) return 'Insira a carga horária inicial';
    return null;
  }

  departamentValidator(String value) {
    if (value.isEmpty) return 'Insira o departamento';
  }

  dateValidator(value) {
    if (value == "") return 'Selecione uma data';
    if (value.length < 10) return 'Informe uma data válida';
  }

  void createUser(user) {
    this.userProvider.create(this.image.value, user).then(
      (value) {
        this.toUsersList();
        Get.defaultDialog(
          content: Text('Usuário criado com sucesso!'),
        );
      },
      onError: (err) => Get.defaultDialog(
        content: Text(err.message ?? 'Erro ao  criar usuário'),
      ),
    ).whenComplete(() => isLoading(false));
  }

  updateUser(user) {
    this.userProvider.update(this.image.value, user).then(
      (value) {
        Get.defaultDialog(
          content: Text('Usuário atualizado com sucesso!'),
        );
        this.toUserDetails();
      },
      onError: (err) => Get.defaultDialog(
        content: Text(err.message ?? 'Erro ao atualizar dados do usuário'),
      ),
    ).whenComplete(() => isLoading(false));
  }

  toUsersList() {
    Get.rootDelegate.toNamed(Routes.USERS);
  }

  toUserDetails() {
    Get.rootDelegate.toNamed(Routes.USER_DETAILS(this.userId.toString()));
  }

  displayDatePicker(BuildContext context) async {
    var initialDate = DateTime.now();
    var eventDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(initialDate.year - 10),
      lastDate: DateTime(initialDate.year + 5),
    );
    if (eventDate == null) return;
    dateController.text = DateFormat("dd/MM/yyyy", "pt-BR").format(eventDate);
    // var tryParse =
    //     DateTime.parse(dateController.text.split('/').reversed.join());
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image.value = imageTemporary;
    } on PlatformException catch (e) {
      Get.defaultDialog(
        content: Text('O aplicativo não tem permissão para acessar galeria $e'),
      );
    } catch (e) {
      Get.defaultDialog(
        content: Text('Ocorreu um erro ao selecionar imagem $e'),
      );
    }
  }

  void setForm(User user) {
    this.userImage.value = user.avatar!;
    this.phoneController.text = user.telephone!.toString();
    this.nameController.text = user.name!;
    this.emailController.text = user.email!;
    this.workloadController.text = user.workload.toString();
    this.cpfController.text = user.cpf.toString();
    this.departamentController.text = user.departament!;
    this.dateController.text =
        DateFormat("dd/MM/yyyy", "pt-BR").format(user.entryDate!);
  }

  validateForm() {
    if (this.userFormKey.currentState!.validate()) {
      this.isLoading(true);
      this.userFormKey.currentState!.save();
      var user = this.setFields();
      if (this.isEditing.value)
        this.updateUser(user);
      else
        this.createUser(user);
    }
  }

  setFields() {
    var user = {};
    var date = DateTime.parse(dateController.text.split('/').reversed.join());
    if (isEditing.value) user['id'] = int.parse(this.userId);
    user['email'] = emailController.text;
    user['password'] = "paap";
    user['name'] = nameController.text;
    user['workload'] = int.parse(workloadController.text);
    user['departament'] = departamentController.text;
    user['phone'] = phoneController.text;
    user['cpf'] = cpfController.text;
    user['entryDate'] = date.toIso8601String();
    return user;
  }
}
