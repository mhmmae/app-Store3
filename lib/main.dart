import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscar/controler/local-notification-onroller.dart';
import 'package:oscar/registration/InfomationUser/informationUser.dart';
import 'package:oscar/registration/SginUp/SginUp.dart';
import 'package:oscar/registration/phoneNamber/TextFomeFildeCodePhone.dart';
import 'package:oscar/registration/phoneNamber/codePhoneNumber.dart';
import 'package:oscar/registration/signin/signinPage.dart';
import 'package:oscar/the%D9%80chosen/the%D9%80chosen.dart';

import 'HomePage/home/home.dart';
import 'addItem/addItem.dart';
import 'addItem/addNewItem/informationOFItem.dart';
import 'bottonBar/botonBar.dart';
import 'chat/Chat.dart';
import 'chat/chatMember.dart';
import 'firebase_options.dart';
import 'googleMap/GoogleMapOrder.dart';
import 'googleMap/googleMap.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


   await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  await localNotification.inti();



  await ScreenUtil.ensureScreenSize();



  // WidgetsBinding.instance.addPostFrameCallback((_){
  //   AwesomeNotifications().setListeners(onActionReceivedMethod:onActionReceivedMethod,
  //       onNotificationDisplayedMethod: (re0)async{
  //         print('New action received:qwdqwdwqdqw1 ');
  //       } ,
  //       onNotificationCreatedMethod: (re0)async{
  //         print('New action received:qwdqwdwqdqw2 ');
  //       },
  //       onDismissActionReceivedMethod: (re0)async{
  //         print('New action received:qwdqwdwqdqw 3');
  //       });
  // });









  runApp(const MyApp());
}



FirebaseMessaging messaging = FirebaseMessaging.instance;








//
//
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       displayOnBackground: true,
//
//
//       color: Colors.red,
//
//
//       id: 10,
//       largeIcon: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIPaZuF36QU4wzIjUyMixqgQrJR22Q-TAhTjrEY-1vfQ&s',
//
//       chronometer: const Duration(seconds: 5),
//
//       summary: 'ssssssssssssss',
//
//       notificationLayout: NotificationLayout.Messaging,
//       roundedLargeIcon: true,
//
//       channelKey: 'basic_channel',
//       fullScreenIntent: true,
//
//       actionType: ActionType.DisabledAction,
//       title: 'Hello World!',
//       body: 'This is my first notification!',
//     ),
//
//   );
//
// }
//



// notification1(){
//   AwesomeNotifications().initialize(
//     // set the icon to null if you want to use the default app icon
//       'resource://drawable/qwe',
//       [
//         NotificationChannel(
//             channelGroupKey: 'basic_channel_group',
//             channelKey: 'basic_channel',
//             channelName: 'Basic notifications',
//             channelDescription: 'Notification channel for basic tests',
//             defaultColor: Color(0xFF9D50DD),
//             playSound: true,
//             channelShowBadge: true,
//             importance: NotificationImportance.Max,
//             onlyAlertOnce: true,
//             criticalAlerts: true,
//
//
//             ledColor: Colors.white)
//       ],
//       // Channel groups are only visual and are not required
//       channelGroups: [
//         NotificationChannelGroup(
//             channelGroupKey: 'basic_channel_group',
//             channelGroupName: 'Basic group')
//       ],
//       debug: true
//   );
// }


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;

    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: MediaQuery.of(context).size.width>=270?const Size(320, 480):const Size(1280, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          // You can use the library anywhere in the app even in theme

          home: child,
        );
      },
      child: home()
    );
  }
}
