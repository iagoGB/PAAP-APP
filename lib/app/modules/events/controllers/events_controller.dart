import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/event_provider.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class EventsController extends GetxController with StateMixin {
  final EventProvider eventProvider;
  String text = 'Buêêêên';
  // final events = <Event>[].obs;

  EventsController(this.eventProvider);

  @override
  void onInit() {
    super.onInit();
  }

  void getOpens() async {
    await this.eventProvider.getOpens().then((events) {
      change(events,
          status: events.length == 0 ? RxStatus.empty() : RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error("Erro ao buscar eventos abertos"));
    });
  }

  @override
  void onReady() {
    super.onReady();
    this.getOpens();
  }

  @override
  void onClose() {}

  void toDetailsEvent(id) {
    Get.rootDelegate.toNamed(Routes.EVENT_DETAILS(id.toString()));
  }
}
