import 'package:get/get.dart';

class EventDetailsController extends GetxController {
  final String productId;

  EventDetailsController(this.productId);

  @override
  void onInit() {
    super.onInit();
    Get.log('ProductDetailsController created with id: $productId');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
