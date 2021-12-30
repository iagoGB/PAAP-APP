import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:paap_app/app/data/models/event_model.dart';
import 'package:paap_app/app/data/providers/event_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';
import 'package:paap_app/app/data/providers/user_provider.dart';
import 'package:paap_app/app/modules/root/controllers/root_controller.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class EventDetailsController extends GetxController with StateMixin {
  final RootController rootController = Get.find();
  final StorageProvider storageProvider;
  final EventProvider eventProvider;
  final UserProvider userProvider;
  final isSubscribed = false.obs;
  final isPresent = false.obs;
  final isLoading = true.obs;
  final subscribing = false.obs;
  final error = false.obs;
  final String eventId;
  late Event event;

  EventDetailsController(
    this.eventId,
    this.storageProvider,
    this.eventProvider,
    this.userProvider,
  );

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    this.rootController.setBackButton(Routes.HOME);
    this.findByID(eventId);
  }

  @override
  void onClose() {}

  void findByID(String eventId) async {
    isLoading(true);
    await this
        .eventProvider
        .findByID(eventId)
        .then((value) => event = value, onError: (err) => error(true));
    this.checkIfSubscribed();
  }

  String getSpeakers() {
    String speakers = '';
    this.event.speakers!.forEach((speaker) {
      speakers += '$speaker,';
    });
    return speakers;
  }

  void checkIfSubscribed() async {
    var userId = storageProvider.getAuth()['id'];
    await this.userProvider.getById(userId).then((user) {
      var result =
          user?.events?.any((eventUser) => eventUser.id == this.event.id);
      isSubscribed(result);
    }).whenComplete(() => isLoading(false));
  }

  void subscribeToEvent() {
    subscribing(true);
    var userId = storageProvider.getAuth()['id'];
    this
        .eventProvider
        .subscribe(this.eventId, userId)
        .then((value) => isSubscribed(true))
        .whenComplete(() => subscribing(false));
  }

  void unsubscribeToEvent() {
    subscribing(true);
    var userId = storageProvider.getAuth()['id'];
    this
        .eventProvider
        .unsubscribe(this.eventId, userId)
        .then((value) => isSubscribed(false))
        .whenComplete(() => subscribing(false));
  }

  void readQrCode() async {
    String code = '';
    try {
      code = await FlutterBarcodeScanner.scanBarcode(
        Get.isDarkMode ? '#FFFF00' : '#00A294',
        'Cancelar',
        true,
        ScanMode.QR,
      );
      print('code -$code');
    } catch (e) {
      this.feedbackMessage(
        Colors.redAccent,
        'Erro',
        'Erro ao usar Scanner.',
      );
    }
    if (code != '-1' && code != '') {
      print('ta entrando aqui');
      this.registerPresence(code);
    } else {
      this.feedbackMessage(
        Colors.redAccent,
        null,
        'Você cancelou a leitura do QrCode',
      );
    }
  }

  void registerPresence(String code) async {
    this.eventProvider.registerPresence(eventId, code).then(
      (value) {
        isPresent(true);
        this.feedbackMessage(Get.theme.primaryColor, 'Tudo certo!',
            'Sua presença foi registrada!');
      },
      onError: (err) {
        print(err);
        isPresent(false);
        this.feedbackMessage(Colors.redAccent, 'Erro', err.message);
      },
    );
  }

  void feedbackMessage(color, title, message) {
    Get.defaultDialog(
      backgroundColor: color,
      title: title != null ? title : '',
      titleStyle: TextStyle(color: Colors.white),
      middleText: message,
      middleTextStyle: TextStyle(color: Colors.white),
    );
  }
}
