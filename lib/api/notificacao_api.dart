import 'package:easy_med/telas/tela_notificacao.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  static final onNotifications = BehaviorSubject<String?>();



  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();


  Future<void> init({bool initScheduled = false}) async {

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
     }



  Future selectNotification(String? payload) async {
    onNotifications.add(payload);
  }

  AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    'channelID',
    'channelName',
    playSound: true,
    priority: Priority.max,
    importance: Importance.max,
    fullScreenIntent: true,
  );

  Future<void> showNotifications() async {
    await flutterLocalNotificationsPlugin.show(
      1,
      "Hora do Medicamento",
      "Vai tomar esse remedio ai filhão",
      NotificationDetails(android: _androidNotificationDetails),
    );
  }
}
