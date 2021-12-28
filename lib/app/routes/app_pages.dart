import 'package:get/get.dart';

import 'package:paap_app/app/middlewares/auth_middleware.dart';
import 'package:paap_app/app/modules/admin/bindings/admin_binding.dart';
import 'package:paap_app/app/modules/admin/views/admin_view.dart';
import 'package:paap_app/app/modules/admin_events/bindings/admin_events_binding.dart';
import 'package:paap_app/app/modules/admin_events/views/admin_events_view.dart';
import 'package:paap_app/app/modules/event_details/bindings/event_details_binding.dart';
import 'package:paap_app/app/modules/event_details/views/event_details_view.dart';
import 'package:paap_app/app/modules/events/bindings/events_binding.dart';
import 'package:paap_app/app/modules/events/views/events_view.dart';
import 'package:paap_app/app/modules/home/bindings/home_binding.dart';
import 'package:paap_app/app/modules/home/views/home_view.dart';
import 'package:paap_app/app/modules/login/bindings/login_binding.dart';
import 'package:paap_app/app/modules/login/views/login_view.dart';
import 'package:paap_app/app/modules/notifications/bindings/notifications_binding.dart';
import 'package:paap_app/app/modules/notifications/views/notifications_view.dart';
import 'package:paap_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:paap_app/app/modules/profile/views/profile_view.dart';
import 'package:paap_app/app/modules/root/bindings/root_binding.dart';
import 'package:paap_app/app/modules/root/views/root_view.dart';
import 'package:paap_app/app/modules/search/bindings/search_binding.dart';
import 'package:paap_app/app/modules/search/views/search_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

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
            EnsureNotAuthedMiddleware(),
          ],
          name: _Paths.LOGIN,
          page: () => LoginView(),
          binding: LoginBinding(),
        ),
        GetPage(
          middlewares: [
            EnsureAuthMiddleware(),
          ],
          preventDuplicates: true,
          name: _Paths.HOME,
          page: () => HomeView(),
          bindings: [
            HomeBinding(),
          ],
          title: null,
          children: [
            GetPage(
              middlewares: [
                EnsureAuthMiddleware(),
              ],
              name: _Paths.EVENTS,
              page: () => EventsView(),
              binding: EventsBinding(),
            ),
            GetPage(
              middlewares: [
                //only enter this route when authed
                EnsureAuthMiddleware(),
              ],
              name: _Paths.SEARCH,
              page: () => SearchView(),
              title: 'Profile',
              transition: Transition.size,
              binding: SearchBinding(),
            ),
            GetPage(
              middlewares: [
                EnsureAuthMiddleware(),
              ],
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
          middlewares: [
            EnsureAuthMiddleware(),
          ],
          name: _Paths.PROFILE,
          page: () => ProfileView(),
          binding: ProfileBinding(),
        ),
        GetPage(
          transition: Transition.zoom,
          name: _Paths.EVENT_DETAILS,
          page: () => EventDetailsView(),
          binding: EventDetailsBinding(),
        ),
        GetPage(
          middlewares: [],
          preventDuplicates: true,
          name: _Paths.ADMIN,
          page: () => AdminView(),
          bindings: [
            AdminBinding(),
          ],
          title: null,
          children: [
            GetPage(
              name: _Paths.ADMIN_EVENTS,
              page: () => AdminEventsView(),
              binding: AdminEventsBinding(),
            ),
          ],
        )
      ],
    ),
  ];
}
