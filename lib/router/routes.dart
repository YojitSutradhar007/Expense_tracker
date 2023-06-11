import 'package:expense_tracker_dev/screens/screens.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: "/HomeScreen",
      builder: (context, state) =>   HomeScreen(),
    ),
  ],
);
