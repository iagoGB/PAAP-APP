import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:paap_app/app/data/models/category_model.dart';
import 'package:paap_app/app/data/models/event_model.dart';
import 'package:paap_app/app/data/providers/category_provider.dart';

import 'package:paap_app/app/data/providers/event_provider.dart';
import 'package:paap_app/app/modules/admin_events/controllers/admin_events_controller.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class EditEventController extends GetxController {
  final EventProvider eventProvider;
  final CategoryProvider categoryProvider;
  final eventFormKey = GlobalKey<FormState>();
  var titleController = TextEditingController(text: "");
  var dateController = TextEditingController(text: "");
  var timeController = TextEditingController(text: "");
  var workloadController = TextEditingController(text: "");
  var speakerController = TextEditingController(text: "");
  var descriptionController = TextEditingController(text: "");
  var locationController = TextEditingController(text: "");
  var isEditing = false.obs;
  var isLoading = false.obs;
  var categories = <Category>[].obs;
  int? selectedCategory;
  var eventImage = "".obs;
  var imageFeedback = "".obs;
  var appBarTitle = "Criar evento".obs;
  var image = Rxn<File?>();
  final String eventId;

  EditEventController(
    this.eventId, {
    required this.categoryProvider,
    required this.eventProvider,
  });

  @override
  void onInit() {
    super.onInit();
    this.checkIfIsEditing();
  }

  @override
  void onReady() {
    super.onReady();
    this.getCategories();
  }

  @override
  void onClose() {
    isEditing(false);
  }

  void getCategories() async {
    await this.categoryProvider.getAll().then(
      (value) {
        categories.assignAll(value);
        update();
      },
      onError: (err) => Get.defaultDialog(
        content: Text('Erro ao buscar as categorias. $err'),
      ),
    ).whenComplete(() => null);
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

  titleValidator(String value) {
    if (value.length < 3) return 'Título muito curto';
    return null;
  }

  dateValidator(String value) {
    if (value == "") return 'Selecione uma data';
  }

  timeValidator(String s) {
    if (s == "") return 'Selecione uma horário';
  }

  workloadValidator(value) {
    if (value == "" || value == "0") return 'Carga horária não pode ser vazia';
    final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
    if (!validCharacters.hasMatch(value))
      return 'Apenas números são permitidos';
  }

  speakerValidator(String value) {
    if (value.trim().isEmpty) return 'Informe um palestrante';
  }

  validateCategory(value) {
    print(value);
    if (value == null) return 'Selecione uma categoria';
  }

  locationValidator(String value) {
    if (value.isEmpty) return "Informe uma localização";
    return null;
  }

  descriptionValidator(value) {
    // if (value.trim().isEmpty) return 'Insira uma descrição';
    return null;
  }

  displayDatePicker(BuildContext context) async {
    var initialDate = DateTime.now();
    var eventDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(initialDate.year + 5),
    );
    if (eventDate == null) return;
    dateController.text = DateFormat("dd/MM/yyyy", "pt-BR").format(eventDate);
    // var tryParse =
    //     DateTime.parse(dateController.text.split('/').reversed.join());
  }

  displayTimePick(context) async {
    var initialTime = TimeOfDay(hour: 09, minute: 00);
    var newTime =
        await showTimePicker(context: context, initialTime: initialTime);
    if (newTime == null) return;
    final hour = newTime.hour.toString().padLeft(2, '0');
    final minute = newTime.minute.toString().padLeft(2, '0');
    timeController.text = '$hour:$minute';
  }

  submit() {
    if (isEditing.value) {
      validateForm();
    } else {
      var haveImage = image.value != null;
      if (!haveImage) {
        imageFeedback.value = "Selecione uma imagem";
        return;
      }
      validateForm();
    }
  }

  void validateForm() {
    if (this.eventFormKey.currentState!.validate()) {
      isLoading(true);
      this.eventFormKey.currentState!.save();
      var event = this.setFields();
      if (this.isEditing.value) {
        event['id'] = this.eventId;
        this.updateEvent(image.value, event);
      } else {
        this.postEvent(image.value, event);
      }
    }
  }

  void checkIfIsEditing() async {
    if (this.eventId.isEmpty) return;
    appBarTitle.value = 'Editar evento';
    isLoading(true);
    await this
        .eventProvider
        .findByID(eventId)
        .then((value) => fillForm(value), onError: (err) => print(err))
        .whenComplete(() => isLoading(false));
  }

  fillForm(Event event) {
    isEditing(true);
    this.eventImage.value = event.picture!;
    this.selectedCategory = event.category!.id;
    this.titleController.text = event.title!;
    this.locationController.text = event.location!;
    this.workloadController.text = event.workload.toString();
    this.descriptionController.text = event.description ?? '';
    this.speakerController.text =
        event.speakers!.isEmpty ? 'Não possui' : event.speakers![0];
    this.dateController.text =
        DateFormat("dd/MM/yyyy", "pt-BR").format(event.dateTime!);
    final hour = event.dateTime!.hour.toString().padLeft(2, '0');
    final minute = event.dateTime!.minute.toString().padLeft(2, '0');
    this.timeController.text = '$hour:$minute';
  }

  void postEvent(File? value, Map event) {
    this.eventProvider.postEvent(image.value, event).then(
      (value) {
        Get.defaultDialog(
          content: Text("Novo evento criado com sucesso!"),
        );
        Get.rootDelegate.toNamed(Routes.ADMIN_EVENTS);
        this.reloadEventsList();
      },
      onError: (err) => Get.defaultDialog(
        content: Text("Ocorreu um erro ao criar o evento."),
      ),
    ).whenComplete(() => isLoading(false));
  }

  void updateEvent(File? value, Map event) {
    this.eventProvider.updateEvent(image.value, event).then(
      (value) {
        Get.defaultDialog(
          content: Text("Evento atualizado com sucesso!"),
        );
        Get.rootDelegate.toNamed(Routes.ADMIN_EVENTS);
        this.reloadEventsList();
      },
      onError: (err) => Get.defaultDialog(
        content: Text("Ocorreu um erro ao atualizar o evento."),
      ),
    ).whenComplete(() => isLoading(false));
  }

  setFields() {
    var date = DateTime.parse(dateController.text.split('/').reversed.join());
    var time = TimeOfDay(
      hour: int.parse(timeController.text.split(':')[0]),
      minute: int.parse(timeController.text.split(':')[1]),
    );
    var dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    var event = {};
    event['category'] = selectedCategory;
    event['title'] = titleController.text;
    event['workload'] = int.parse(workloadController.text);
    event['speakers'] = [speakerController.text];
    event['location'] = locationController.text;
    event['description'] = descriptionController.text;
    event['dateTime'] = dateTime.toIso8601String();
    return event;
  }

  reloadEventsList() {
    var eventsListView = Get.find<AdminEventsController>();
    eventsListView.onInit();
  }
}
