import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Home_page.dart';
import 'package:myapp/chat_user.dart';
import 'package:myapp/local.dart';
import 'package:myapp/login.dart';
import 'package:myapp/splash_screen.dart';


 Future<void> backgroundHandler(RemoteMessage message) async{
   print(message);
  }

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   FirebaseMessaging.onBackgroundMessage(backgroundHandler);
   LocalService.initialize();
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
 }


class _MyappState extends State<Myapp> {

  List<ChatUser> list = [];
  final List<ChatUser> searchList = [];
  bool isSearch = false;
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;

    FirebaseMessaging.instance.getInitialMessage().then((message) {
     print('FirebaseMessaging.instance.getInitialMessage');
    });

    FirebaseMessaging.onMessage.listen((message){
      print(' FirebaseMessaging.onMessage.listen');
      if(message.notification != null){
       LocalService.displayNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('FirebaseMessaging.onMessageOpenedApp.listen');
    });
  }


  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       home: SplashScreen(),
     //  user != null ? const HomePage() : const Login(),
     );
  }
}

