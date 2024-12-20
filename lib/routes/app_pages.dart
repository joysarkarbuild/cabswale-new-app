import 'package:cabswalle/modules/insurance/insurance_screen1.dart';
import 'package:cabswalle/modules/loan/screen/loan_screen.dart';
import 'package:cabswalle/modules/services/screen/services_view.dart';
import 'package:cabswalle/modules/language/screen/language_screen.dart';
import 'package:cabswalle/modules/myprofile/screen/myprofile_view.dart';
import 'package:cabswalle/modules/setting/screen/setting_view.dart';
import 'package:cabswalle/modules/splash/screen/splash_view.dart';
import 'package:cabswalle/modules/verifyAccount/screen/edit_name_city_profile_image.dart';
import 'package:cabswalle/modules/verifyAccount/screen/edit_top_routes.dart';
import 'package:cabswalle/modules/verifyAccount/screen/edit_vehicles.dart';
import 'package:cabswalle/modules/verifyAccount/screen/verify_account_view.dart';
import 'package:cabswalle/modules/emergency/screen/emergency_view.dart';
import 'package:cabswalle/modules/topLocations/screen/top_locations_view.dart';
import 'package:cabswalle/modules/referAndEarn/screen/refer_and_earn_view.dart';
import 'package:cabswalle/modules/videosFromRealDrivers/screen/videos_from_real_drivers_view.dart';
import 'package:cabswalle/modules/partnerWithUs/screen/partner_with_us_view.dart';
import 'package:cabswalle/modules/reportProblem/screen/report_problem_view.dart';
import 'package:cabswalle/modules/nearbyPlace/screen/nearby_place_view.dart';
import 'package:cabswalle/modules/nearbyDriver/screen/nearby_driver_view.dart';
import 'package:cabswalle/modules/nearby/screen/nearby_view.dart';
import 'package:cabswalle/modules/extraBenifits/screen/extra_benifits_view.dart';
import 'package:cabswalle/modules/productDetails/screen/product_details_view.dart';
import 'package:cabswalle/modules/wallet/screen/wallet_transactions.dart';
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
import 'package:cabswalle/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  navigatorKey:
      GlobalNavigation.instance.navigatorKey, // Use the global key here
  routes: [
    GoRoute(
      name: Names.carInsurance,
      path: Routes.carInsurance,
      builder: (context, state) => const InsuranceScreen1(),
    ),
    GoRoute(
      name: Names.services,
      path: Routes.services,
      builder: (context, state) => const ServicesScreen(),
    ),
    GoRoute(
      name: Names.walletTransactions,
      path: Routes.walletTransactions,
      builder: (context, state) => const WalletTransactionScreen(),
    ),
    GoRoute(
      name: Names.language,
      path: Routes.language,
      builder: (context, state) => const LanguageScreen(),
    ),
    GoRoute(
      name: Names.settings,
      path: Routes.settings,
      builder: (context, state) => const SettingScreen(),
    ),
    GoRoute(
      name: Names.vehicles,
      path: Routes.vehicles,
      builder: (context, state) => const EditVehicles(),
    ),
    GoRoute(
      name: Names.editTopRoutes,
      path: Routes.editTopRoutes,
      builder: (context, state) => const EditTopRoutes(),
    ),
    GoRoute(
      name: Names.editNameCityAndProfilePicture,
      path: Routes.editNameCityAndProfilePicture,
      builder: (context, state) => const EditNameCityAndProfileImage(),
    ),
    GoRoute(
      name: Names.myprofile,
      path: Routes.myprofile,
      builder: (context, state) => const MyprofileScreen(),
    ),
    GoRoute(
      name: Names.verifyAccount,
      path: Routes.verifyAccount,
      builder: (context, state) => const VerifyAccountScreen(),
    ),
    GoRoute(
      name: Names.emergency,
      path: Routes.emergency,
      builder: (context, state) => const EmergencyScreen(),
    ),
    GoRoute(
      name: Names.topLocations,
      path: Routes.topLocations,
      builder: (context, state) => const TopLocationsScreen(),
    ),
    GoRoute(
      name: Names.referAndEarn,
      path: Routes.referAndEarn,
      builder: (context, state) => const ReferAndEarnScreen(),
    ),
    GoRoute(
      name: Names.videosFromRealDrivers,
      path: Routes.videosFromRealDrivers,
      builder: (context, state) => const VideosFromRealDriversScreen(),
    ),
    GoRoute(
      name: Names.partnerWithUs,
      path: Routes.partnerWithUs,
      builder: (context, state) => const PartnerWithUsScreen(),
    ),
    GoRoute(
      name: Names.reportProblem,
      path: Routes.reportProblem,
      builder: (context, state) => const ReportProblemScreen(),
    ),
    GoRoute(
      name: Names.nearbyPlace,
      path: Routes.nearbyPlace,
      builder: (context, state) => NearbyPlaceScreen(
        typeOfPlace: state.extra as String,
      ),
    ),
    GoRoute(
      name: Names.nearbyDriver,
      path: Routes.nearbyDriver,
      builder: (context, state) => const NearbyDriverScreen(),
    ),
    GoRoute(
      name: Names.nearby,
      path: Routes.nearby,
      builder: (context, state) => const NearbyScreen(),
    ),
    GoRoute(
      name: Names.loan,
      path: Routes.loan,
      builder: (context, state) => const LoanScreen(),
    ),
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
        verificationId: state.extra as String,
      ),
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

class GlobalNavigation {
  static final GlobalNavigation instance = GlobalNavigation._internal();
  GlobalNavigation._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
