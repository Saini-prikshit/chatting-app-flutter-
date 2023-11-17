import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalService{
 static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
 static void initialize() {
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher')
    );
    _notificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: (details) {
      if(details.input != null){}
    },
    );
 }
 static void displayNotification(RemoteMessage message) async{
    try{
      final id = DateTime.now().microsecond;
       NotificationDetails notificationDetails = const NotificationDetails(
         android: AndroidNotificationDetails(
             'myapp',
             'myappchannel',
             importance: Importance.max,
             priority: Priority.max,
         )
       );
         await _notificationsPlugin.show(
           id,
           message.notification!.title,
           message.notification!.body,
           notificationDetails);
    } catch(e){
      print(e);
    }
 }
}
