import 'package:get/get.dart';

class RootController extends GetxController {
  //TODO: Implement RootController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print('instanciou o root');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
