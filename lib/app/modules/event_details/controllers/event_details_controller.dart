import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:paap_app/app/data/models/event_model.dart';
import 'package:paap_app/app/data/models/user_model.dart';
import 'package:paap_app/app/data/providers/event_provider.dart';
import 'package:paap_app/app/data/providers/storage_provider.dart';
import 'package:paap_app/app/data/providers/user_provider.dart';
import 'package:paap_app/app/modules/root/controllers/root_controller.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class EventDetailsController extends GetxController with StateMixin {
  final RootController rootController = Get.find();
  final StorageProvider storageProvider;
  final EventProvider eventProvider;
  final UserProvider userProvider;
  final isAdmin = false.obs;
  final userStatus = "".obs;
  final isLoading = true.obs;
  final subscribing = false.obs;
  final error = false.obs;
  final String eventId;
  User? user;
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
    BackButtonInterceptor.add(myInterceptor);
    this.checkIfIsAdmin();
  }

  @override
  void onReady() {
    super.onReady();
    this.findByID(eventId);
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    this.getBack(); // Do some stuff.
    return true;
  }

  @override
  void onClose() {}

  void findByID(String eventId) async {
    isLoading(true);
    await this
        .eventProvider
        .findByID(eventId)
        .then((value) => event = value, onError: (err) => error(true));
    this.checkUserStatus();
  }

  String getSpeakers() {
    String speakers = '';
    this.event.speakers!.forEach((speaker) {
      speakers += '$speaker';
    });
    return speakers;
  }

  void checkUserStatus() async {
    var userId = storageProvider.getAuth()['id'];
    await this.userProvider.getById(userId).then((user) {
      this.user = user;
      var result =
          user?.events?.where((eventUser) => eventUser.id == this.event.id);
      if (result!.length > 0) {
        var eventUser = result.first;
        var isPresent = eventUser.isPresent ?? false;
        if (isPresent)
          userStatus('isPresent');
        else
          userStatus('isEnrolled');
      } else
        userStatus('isUnsubscribed');
    }).whenComplete(() => isLoading(false));
  }

  void subscribeToEvent() {
    subscribing(true);
    var userId = storageProvider.getAuth()['id'];
    this
        .eventProvider
        .subscribe(this.eventId, userId)
        .then((value) => userStatus('isEnrolled'))
        .whenComplete(() => subscribing(false));
  }

  void unsubscribeToEvent() {
    subscribing(true);
    var userId = storageProvider.getAuth()['id'];
    this
        .eventProvider
        .unsubscribe(this.eventId, userId)
        .then((value) => userStatus('isUnsubscribed'))
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
    } catch (e) {
      this.feedbackMessage(
        Colors.redAccent,
        'Erro',
        'Erro ao usar Scanner.',
      );
    }
    if (code != '-1' && code != '') {
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
        userStatus('isPresent');
        this.feedbackMessage(
          Get.theme.primaryColor,
          'Tudo certo!',
          'Sua presença foi registrada!',
        );
      },
      onError: (err) {
        this.feedbackMessage(
          Colors.redAccent,
          'Erro',
          err.message ?? 'Erro ao registrar presença',
        );
      },
    );
  }

  void feedbackMessage(color, title, message) {
    Get.defaultDialog(
      backgroundColor: color,
      title: title ?? '',
      titleStyle: TextStyle(color: Colors.white),
      middleText: message,
      middleTextStyle: TextStyle(color: Colors.white),
    );
  }

  downloadCertificate() {
    isLoading(true);
    this.eventProvider.downloadCertificate(this.event, this.user).then(
      (value) {
        OpenFile.open(value!.path);
      },
      onError: (err) => Get.defaultDialog(
        content: Text(err.message ?? 'Erro ao baixar certificado'),
      ),
    ).whenComplete(() => isLoading(false));
  }

  void getBack() {
    var auth = storageProvider.getAuth();
    if (auth?['role'] == 'ADMIN')
      Get.rootDelegate.offAndToNamed(Routes.ADMIN_EVENTS);
    if (auth?['role'] == 'USER') Get.rootDelegate.offAndToNamed(Routes.HOME);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkIfIsAdmin() {
    var auth = storageProvider.getAuth();
    if (auth?['role'] == 'ADMIN') isAdmin(true);
  }

  editEvent(String eventId) {
    Get.rootDelegate.toNamed(Routes.UPDATE_EVENT(eventId));
  }
}
