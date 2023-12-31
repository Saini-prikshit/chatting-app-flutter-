import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Home_page.dart';
import 'package:myapp/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    Future.delayed(Duration(seconds: 2),(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  user != null ? HomePage() : Login(),));}
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
       height: double.infinity,
       width: double.infinity,
       child: SingleChildScrollView(
         child: Column(
           children: [
             Padding(
               padding: const EdgeInsets.only(top: 350,left: 140,right: 140),
               child: Image.asset('images/speech-bubble.png',),
             ),
            SizedBox(height: MediaQuery.of(context).size.height*0.38,),
            Text('Made In India 🇮🇳',style: TextStyle(fontSize: 22,color: Colors.white))
           ],
         ),
       ),
       decoration: BoxDecoration(
         gradient: LinearGradient(colors: [Colors.blue,Colors.pink],begin: Alignment.topLeft,end: Alignment.bottomRight,),
       ),
         ),
    );
  }
  void navigate(){
    if(user != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
    } else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
    }
  }
}
