import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cabswalle/app.dart';
import 'package:cabswalle/firebase_options.dart';
import 'package:cabswalle/notification/firebase_messaging_service.dart';
import 'package:cabswalle/services/typesense_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Makes status bar transparent
      statusBarIconBrightness: Brightness.dark, // Sets text and icons to black
    ),
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await AwesomeNotifications().initialize(
    'resource://drawable/ic_launcher', // App icon resource
    [
      NotificationChannel(
        channelKey: 'cabswale_lead',
        channelName: 'Leads Notification',
        channelDescription: 'Channel for Leads notification',
        importance: NotificationImportance.High,
        playSound: true,
        soundSource: 'resource://raw/cabswale', // Custom sound resource
      ),
    ],
  );

  await FirebaseService.initialize();
  await TypeSenseInstance().getKeys();
  runApp(const MyApp());
}
