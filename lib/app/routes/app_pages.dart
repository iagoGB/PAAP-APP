import 'package:get/get.dart';

import 'package:paap_app/app/modules/events/events_binding.dart';
import 'package:paap_app/app/modules/events/events_view.dart';
import 'package:paap_app/app/modules/home/home_binding.dart';
import 'package:paap_app/app/modules/home/home_view.dart';
import 'package:paap_app/app/modules/login/login_binding.dart';
import 'package:paap_app/app/modules/login/login_view.dart';
import 'package:paap_app/app/modules/notifications/notifications_binding.dart';
import 'package:paap_app/app/modules/notifications/notifications_view.dart';
import 'package:paap_app/app/modules/search/search_binding.dart';
import 'package:paap_app/app/modules/search/search_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.EVENTS,
      page: () => EventsView(),
      binding: EventsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
  ];
}
