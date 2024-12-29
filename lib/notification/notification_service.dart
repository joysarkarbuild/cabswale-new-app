import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static void showNotification(String title, String body, String phoneNumber) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'cabswale_lead',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
        customSound: 'resource://raw/cabswale', // Path to custom sound
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'OPEN_WHATSAPP',
          label: 'Open WhatsApp',
          autoDismissible: true,
          enabled: true,
        ),
        NotificationActionButton(
          key: 'CALL_PHONE',
          label: 'Call',
          autoDismissible: true,
          enabled: true,
        ),
      ],
    );

    // AwesomeNotifications().ac.listen((receivedAction) async {
    //   if (receivedAction.buttonKeyPressed == 'OPEN_WHATSAPP') {
    //     final whatsappUrl = "https://wa.me/$phoneNumber";
    //     if (await canLaunch(whatsappUrl)) {
    //       await launch(whatsappUrl);
    //     } else {
    //       print("Cannot open WhatsApp");
    //     }
    //   } else if (receivedAction.buttonKeyPressed == 'CALL_PHONE') {
    //     final phoneUrl = "tel:$phoneNumber";
    //     if (await canLaunch(phoneUrl)) {
    //       await launch(phoneUrl);
    //     } else {
    //       print("Cannot make a call");
    //     }
    //   }
    // });
  }
}
