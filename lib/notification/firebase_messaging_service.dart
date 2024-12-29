import 'package:cabswalle/services/logger_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'notification_service.dart';

class FirebaseService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> initialize() async {
    // Request permissions for iOS
    await _firebaseMessaging.requestPermission();

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final data = message.data;
      LoggerService.logInfo(
          "Foreground Notification received: ${message.data}");
      if (notification != null) {
        final phoneNumber = data['phoneNumber'] ?? '';
        NotificationService.showNotification(
          notification.title ?? 'New Notification',
          notification.body ?? 'You have a new message',
          phoneNumber,
        );
      }
    });

    // Register background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Get the FCM token for testing
    String? token = await _firebaseMessaging.getToken();
    LoggerService.logInfo("FCM Token: $token");
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final notification = message.notification;
  final data = message.data;

  LoggerService.logInfo("Background Notification received: ${message.data}");

  if (notification != null) {
    final phoneNumber = data['phoneNumber'] ?? '';
    NotificationService.showNotification(
      notification.title ?? 'New Notification',
      notification.body ?? 'You have a new message',
      phoneNumber,
    );
  }
}
