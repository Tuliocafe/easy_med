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

  Future<void> showNotifications(int idagenda, String? nomeMedicamento, String? dosagem) async {
    await flutterLocalNotificationsPlugin.show(
      idagenda,
      "Hora do Medicamento",
      "Favor tomar o medicamento $nomeMedicamento, $dosagem",
      NotificationDetails(android: _androidNotificationDetails),
    );
  }
}

// class app extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//
//     return MaterialApp(
//       // debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: notificacao(),
//       // home: notificacao()
//       // home: TelaUsuario(),
//       // home: cadastroUsuario(),
//       // home: alarme(),
//     );
//   }
// }