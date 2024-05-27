
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class localNotification{
static  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
static ontap(NotificationResponse response){
  print('111111111111111111111111ddd11111111111');
  print('1111111111111111111111111122111111111');


}

 static Future inti()async{
    InitializationSettings initializationSettings =const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings()
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onDidReceiveBackgroundNotificationResponse: ontap,
    onDidReceiveNotificationResponse: ontap);
  }

  static void showNotofication ()async{
  NotificationDetails details =const NotificationDetails(
    android: AndroidNotificationDetails(
      '12',
      'bisic',
      importance: Importance.max,
      priority: Priority.max

    )
  );

 await flutterLocalNotificationsPlugin.show(1, 'title', 'body', details);
  }

}