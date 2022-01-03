part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const PROFILE = _Paths.PROFILE;
  static const EVENTS = _Paths.HOME + _Paths.EVENTS;
  static const SEARCH = _Paths.HOME + _Paths.SEARCH;
  static const NOTIFICATIONS = _Paths.HOME + _Paths.NOTIFICATIONS;
  static const ADMIN = _Paths.ADMIN;
  static const ADMIN_EVENTS = _Paths.ADMIN + _Paths.ADMIN_EVENTS;
  // static const EVENT_DETAILS = _Paths.EVENT_DETAILS;
  static String EVENT_DETAILS(String eventId) =>
      _Paths.EVENT_DETAILS.replaceAll(':eventId', eventId);
  static const USERS = _Paths.ADMIN + _Paths.USERS;
}

abstract class _Paths {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const PROFILE = '/profile';
  static const EVENTS = '/events';
  static const SEARCH = '/search';
  static const NOTIFICATIONS = '/notifications';
  static const ADMIN = '/admin';
  static const ADMIN_EVENTS = '/admin-events';
  static const EVENT_DETAILS = '/event-details/:eventId';
  static const USERS = '/users';
}
