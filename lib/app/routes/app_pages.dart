import 'package:get/get.dart';

import '../middlewares/auth_middleware.dart';
import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/admin_events/bindings/admin_events_binding.dart';
import '../modules/admin_events/views/admin_events_view.dart';
import '../modules/event_details/bindings/event_details_binding.dart';
import '../modules/event_details/views/event_details_view.dart';
import '../modules/events/bindings/events_binding.dart';
import '../modules/events/views/events_view.dart';
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
import '../modules/users/bindings/users_binding.dart';
import '../modules/users/views/users_view.dart';

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
                EnsureAuthMiddleware(),
              ],
              name: _Paths.PROFILE,
              page: () => ProfileView(),
              binding: ProfileBinding(),
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
            GetPage(
              name: _Paths.USERS,
              page: () => UsersView(),
              binding: UsersBinding(),
              children: [
                GetPage(
                  name: _Paths.USERS,
                  page: () => UsersView(),
                  binding: UsersBinding(),
                ),
              ],
            ),
          ],
        )
      ],
    ),
    GetPage(
      middlewares: [
        //only enter this route when not authed
        EnsureNotAuthedMiddleware(),
      ],
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
