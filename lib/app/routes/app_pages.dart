import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/events/views/events_view.dart';
import '../modules/events/bindings/events_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: '/',
      page: () => RootView(),
      binding: RootBinding(),
      participatesInRootNavigator: true,
      preventDuplicates: true,
      children: [
        GetPage(
          middlewares: [
            //only enter this route when not authed
            // EnsureNotAuthedMiddleware(),
          ],
          name: _Paths.LOGIN,
          page: () => LoginView(),
          binding: LoginBinding(),
        ),
        GetPage(
          preventDuplicates: true,
          name: _Paths.HOME,
          page: () => HomeView(),
          bindings: [
            HomeBinding(),
          ],
          title: null,
          children: [
            GetPage(
              name: _Paths.EVENTS,
              page: () => EventsView(),
              binding: EventsBinding(),
            ),
            GetPage(
              middlewares: [
                //only enter this route when authed
                // EnsureAuthMiddleware(),
              ],
              name: _Paths.SEARCH,
              page: () => SearchView(),
              title: 'Profile',
              transition: Transition.size,
              binding: SearchBinding(),
            ),
            GetPage(
              name: _Paths.NOTIFICATIONS,
              page: () => NotificationsView(),
              title: 'Products',
              transition: Transition.zoom,
              binding: NotificationsBinding(),
              // children: [
              //   GetPage(
              //     name: _Paths.PRODUCT_DETAILS,
              //     page: () => ProductDetailsView(),
              //     binding: ProductDetailsBinding(),
              //     middlewares: [
              //       //only enter this route when authed
              //       EnsureAuthMiddleware(),
              //     ],
              //   ),
              // ],
            ),
          ],
        ),
        GetPage(
          name: _Paths.PROFILE,
          page: () => ProfileView(),
          binding: ProfileBinding(),
        ),
      ],
    ),
  ];
}
