import 'package:cabswalle/modules/otp/screen/otp_view.dart';
import 'package:cabswalle/modules/login/screen/login_view.dart';
import 'package:cabswalle/modules/splash/screen/splash_view.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: Names.otp,
      path: Routes.otp,
      builder: (context, state) => const OtpScreen(),
    ),

    GoRoute(
      name: Names.splash,
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: Names.login,
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
