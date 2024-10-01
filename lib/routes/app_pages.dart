import 'package:cabswalle/modules/extraBenifits/screen/extra_benifits_view.dart';
import 'package:cabswalle/modules/productDetails/screen/product_details_view.dart';
import 'package:cabswalle/modules/wallet/screen/wallet_view.dart';
import 'package:cabswalle/modules/addlead/screen/addlead_view.dart';
import 'package:cabswalle/modules/filterleads/screen/filterleads_view.dart';
import 'package:cabswalle/modules/cityPreferences/screen/city_preferences_view.dart';
import 'package:cabswalle/modules/myleads/screen/myleads_view.dart';
import 'package:cabswalle/modules/profile/screen/profile_view.dart';
import 'package:cabswalle/modules/deals/screen/deals_view.dart';
import 'package:cabswalle/modules/community/screen/community_view.dart';
import 'package:cabswalle/modules/location/screen/location_view.dart';
import 'package:cabswalle/modules/home/screen/home_view.dart';
import 'package:cabswalle/modules/navbar/screen/navbar_view.dart';
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
      name: Names.extraBenifits,
      path: Routes.extraBenifits,
      builder: (context, state) => const ExtraBenifitsScreen(),
    ),
    GoRoute(
      name: Names.productDetails,
      path: Routes.productDetails,
      builder: (context, state) => const ProductDetailsScreen(),
    ),
    GoRoute(
      name: Names.wallet,
      path: Routes.wallet,
      builder: (context, state) => const WalletScreen(),
    ),
    GoRoute(
      name: Names.myleads,
      path: Routes.myleads,
      builder: (context, state) => const MyLeadsScreen(),
    ),
    GoRoute(
      name: Names.addlead,
      path: Routes.addlead,
      builder: (context, state) => const AddLeadScreen(),
    ),
    GoRoute(
      name: Names.filterleads,
      path: Routes.filterleads,
      builder: (context, state) => const FilterLeadsScreen(
        city: "Kolkata",
      ),
    ),
    GoRoute(
      name: Names.cityPreferences,
      path: Routes.cityPreferences,
      builder: (context, state) => const CityPreferencesScreen(),
    ),
    GoRoute(
      name: Names.profile,
      path: Routes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      name: Names.deals,
      path: Routes.deals,
      builder: (context, state) => const DealsScreen(),
    ),
    GoRoute(
      name: Names.community,
      path: Routes.community,
      builder: (context, state) => const CommunityScreen(),
    ),
    GoRoute(
      name: Names.location,
      path: Routes.location,
      builder: (context, state) => const LocationScreen(),
    ),
    GoRoute(
      name: Names.home,
      path: Routes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: Names.navbar,
      path: Routes.navbar,
      builder: (context, state) => NavbarScreen(),
    ),
    GoRoute(
      name: Names.otp,
      path: Routes.otp,
      builder: (context, state) => OtpScreen(
        phoneNo: state.extra as String,
      ),
    ),
    GoRoute(
      name: Names.splash,
      path: Routes.splash,
      builder: (context, state) => NavbarScreen(),
    ),
    GoRoute(
      name: Names.login,
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
