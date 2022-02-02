import 'package:get/get.dart';
import 'package:paap_app/app/data/providers/user_provider.dart';
import 'package:paap_app/app/routes/app_pages.dart';

class UserDetailsController extends GetxController with StateMixin {
  final UserProvider userProvider;
  final String userId;

  UserDetailsController({required this.userId, required this.userProvider});

  @override
  void onInit() {
    super.onInit();
    this.getById();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getById() {
    var id = int.parse(this.userId);
    this.userProvider.getById(id).then(
          (value) => change(
            value,
            status: RxStatus.success(),
          ),
          onError: (err) => change(
            'Erro ao buscar detalhes do usuário',
            status: RxStatus.error(),
          ),
        );
  }

  toUsersList() {
    Get.rootDelegate.popRoute();
  }

  editUser(userId) {
    Get.rootDelegate.toNamed(Routes.UPDATE_USER(userId.toString()));
  }

  userStatus(status) {
    switch (status) {
      case 'DONE':
        return "Concluído";
      case 'PENDING':
        return "Pendente";
      default:
        return "Em atividade";
    }
  }
}
