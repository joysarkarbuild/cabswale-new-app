import 'package:cabswalle/modules/splash/screen/splash_view.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: Names.splash,
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
  ],
);
