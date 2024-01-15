import 'package:staff/ui/addUser/add_user_view.dart';
import 'package:staff/ui/home/home_screen.dart';
import 'package:staff/ui/home/home_screen_admin.dart';
import 'package:staff/ui/login/login_view.dart';
import 'package:go_router/go_router.dart';
import 'package:staff/ui/login_redirection.dart';

class RoutesHandler {
  static final RoutesHandler _singleton = RoutesHandler._internal();

  factory RoutesHandler() {
    return _singleton;
  }

  RoutesHandler._internal();

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/addUser',
        builder: (context, state) => AddUser(),
      ),
      GoRoute(
        path: '/homeScreenAdmin',
        builder: (context, state) => const HomeScreenAdmin(),
      ),
      GoRoute(
        path: '/homeScreen',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
          path: '/loginRedirection',
          builder: (context, state) => LoginRedirection()),
    ],
  );

  GoRouter getRouter() {
    return _router;
  }

  void pop(context){
    _router.pop(context);
  }
}

class RouterNames {
  static const String homeScreenAdmin = "/homeScreenAdmin";
  static const String homeScreenUser = "/homeScreen";
  static const String login = "/login";
  static const String addUser = "/addUser";
  static const String homeScreen = "/";
  static const String loginRedirection = "/loginRedirection";
}
