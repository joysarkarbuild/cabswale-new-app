import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/modules/addlead/bloc/addlead_bloc.dart';
import 'package:cabswalle/modules/filterleads/bloc/filterleads_bloc.dart';
import 'package:cabswalle/modules/home/bloc/home_bloc.dart';
import 'package:cabswalle/modules/login/bloc/login_bloc.dart';
import 'package:cabswalle/modules/myleads/bloc/myleads_bloc.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_bloc.dart';
import 'package:cabswalle/modules/navbar/bloc/navbar_bloc.dart';
import 'package:cabswalle/modules/services/bloc/services_bloc.dart';
import 'package:cabswalle/modules/splash/bloc/splash_bloc.dart';
import 'package:cabswalle/modules/verifyAccount/bloc/verify_account_bloc.dart';
import 'package:cabswalle/modules/wallet/bloc/wallet_bloc.dart';
import 'package:cabswalle/routes/app_pages.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:cabswalle/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

int appVersion = 31; // Always need to change when we pushing new version $$
int iosAppVersion = 2; // Always need to change when we pushing new version $$
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
          create: (BuildContext context) => SplashBloc(),
        ),
        BlocProvider(
          create: (context) => NavbarBloc(),
        ),
        BlocProvider(
          create: (context) => MyprofileBloc(),
        ),
        BlocProvider(
          create: (context) => AddleadBloc(),
        ),
        BlocProvider(
          create: (context) => VerifyAccountBloc(context.read<MyprofileBloc>()),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => MyleadsBloc(),
        ),
        BlocProvider(
          create: (context) => FilterleadsBloc(),
        ),
        BlocProvider(
          create: (context) => WalletBloc(),
        ),
        BlocProvider(
          create: (context) => ServicesBloc(),
        ),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: SnackbarUtils.snackbarKey,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Cabswale',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.myBlue,
          ),
          useMaterial3: true,
          primaryColor: AppColors.myBlue,
        ),
        supportedLocales: L10n.all,
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      ),
    );
  }
}
