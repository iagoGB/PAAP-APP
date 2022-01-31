import 'package:get/get.dart';

import 'package:paap_app/app/modules/change_password/bindings/change_password_binding.dart';
import 'package:paap_app/app/modules/change_password/views/change_password_view.dart';

import '../middlewares/auth_middleware.dart';
import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/admin_events/bindings/admin_events_binding.dart';
import '../modules/admin_events/views/admin_events_view.dart';
import '../modules/categories/bindings/categories_binding.dart';
import '../modules/categories/views/categories_view.dart';
import '../modules/edit_category/bindings/edit_category_binding.dart';
import '../modules/edit_category/views/edit_category_view.dart';
import '../modules/edit_event/bindings/edit_event_binding.dart';
import '../modules/edit_event/views/edit_event_view.dart';
import '../modules/edit_user/bindings/edit_user_binding.dart';
import '../modules/edit_user/views/edit_user_view.dart';
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
import '../modules/user_details/bindings/user_details_binding.dart';
import '../modules/user_details/views/user_details_view.dart';
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
              title: 'Configurações',
              transition: Transition.zoom,
              binding: NotificationsBinding(),
              children: [
                GetPage(
                  transition: Transition.rightToLeft,
                  name: _Paths.CHANGE_PASSWORD,
                  page: () => ChangePasswordView(),
                  binding: ChangePasswordBinding(),
                ),
                GetPage(
                  transition: Transition.rightToLeft,
                  name: _Paths.ABOUT,
                  page: () => AboutView(),
                  binding: AboutBinding(),
                ),
              ],
            ),
          ],
        ),
        GetPage(
          transition: Transition.rightToLeft,
          name: _Paths.EVENT_DETAILS,
          page: () => EventDetailsView(),
          binding: EventDetailsBinding(),
        ),
        GetPage(
          middlewares: [
            EnsureAuthMiddleware(),
          ],
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
              transition: Transition.fadeIn,
              children: [
                GetPage(
                  name: _Paths.CREATE_EVENT,
                  page: () => EditEventView(),
                  binding: EditEventBinding(),
                ),
                GetPage(
                  name: _Paths.UPDATE_EVENT,
                  page: () => EditEventView(),
                  binding: EditEventBinding(),
                ),
              ],
            ),
            GetPage(
              name: _Paths.USERS,
              page: () => UsersView(),
              binding: UsersBinding(),
              transition: Transition.fadeIn,
              children: [
                GetPage(
                  name: _Paths.USER_DETAILS,
                  page: () => UserDetailsView(),
                  binding: UserDetailsBinding(),
                  transition: Transition.rightToLeft,
                ),
                GetPage(
                  name: _Paths.CREATE_USER,
                  page: () => EditUserView(),
                  binding: EditUserBinding(),
                  transition: Transition.fadeIn,
                ),
                GetPage(
                  name: _Paths.UPDATE_USER,
                  page: () => EditUserView(),
                  binding: EditUserBinding(),
                  transition: Transition.rightToLeft,
                ),
              ],
            ),
            GetPage(
              transition: Transition.fadeIn,
              name: _Paths.CATEGORIES,
              page: () => CategoriesView(),
              binding: CategoriesBinding(),
              children: [
                GetPage(
                  transition: Transition.fadeIn,
                  name: _Paths.CREATE_CATEGORY,
                  page: () => EditCategoryView(),
                  binding: EditCategoryBinding(),
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
