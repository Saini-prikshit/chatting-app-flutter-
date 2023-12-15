import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/API.dart';
import 'package:myapp/chat_user.dart';
import 'package:myapp/chatcard.dart';
import 'package:myapp/login.dart';
import 'package:myapp/setting.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChatUser> list = [];
  final List<ChatUser> searchList = [];
  bool isSearch = false;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if(isSearch){
          setState(() {
            isSearch = !isSearch;
          });
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child:
        Scaffold(
            backgroundColor: Colors.grey.shade300,
            appBar:
            AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade500,
              title:
              isSearch?  Padding(
                padding: const EdgeInsets.only(left: 40),
                child: TextField(cursorColor: Colors.white,
                  autofocus: true,
                  style: const TextStyle(fontSize: 18,color: Colors.black,letterSpacing: 0.5),
                  decoration: InputDecoration(hintText: 'Name.., eMail..',
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.70),fontSize: 18),
                  ),
                  onChanged: (val){
                    searchList.clear();
                    for(var i in list){
                      if(i.name.toLowerCase().contains(val.toLowerCase()) || i.eMail.toLowerCase().contains(val.toLowerCase()) ){
                        searchList.add(i);
                      }
                      setState(() {
                        searchList;
                      });
                    }
                  },
                ),
              ) : const Padding(
                padding: EdgeInsets.only(left: 120),
                child: Text('Chats',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500),
                ),
              ),
              actions: [
                IconButton(onPressed: (){
                  setState(() {
                    isSearch = !isSearch;
                  });
                },
                    icon: Icon(isSearch? Icons.clear : Icons.search)),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child:const Row(
                        children: [
                          Icon(Icons.settings,color: Colors.black),
                          SizedBox(width: 5),
                          Text('settings'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Setting(),));
                      },
                    ),
                    PopupMenuItem(
                      child: const Row(
                        children: [
                          Icon(Icons.logout,color: Colors.black),
                          SizedBox(width: 5),
                          Text('Log out'),
                        ],
                      ),
                      onTap: () async{
                       //Navigator.pop(context);
                        try {
                          await FirebaseAuth.instance.signOut().then((value) =>
                            Navigator.pushReplacement(context ,MaterialPageRoute(builder: (context) => Login(),),)
                          );
                          await GoogleSignIn().signOut().then((value) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
                          });
                          await FacebookAuth.instance.logOut().then((value){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
                          });
                        } on FirebaseAuthException catch (e) {
                          print(e);
                          DialogAlert().dialog('Error', e.message!, context);
                        }
                      },
                    ),
                  ]
                  ,)
              ],
            ),
            body:
            StreamBuilder (
              stream: Apis.firestore.collection('users').where('id',isNotEqualTo: Apis.auth.currentUser!.uid).snapshots(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(child: (CircularProgressIndicator()));
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    // for(var i in data!){
                    //   print(i.data());
                    //  list.add(i.data()['name']);
                    // }

                    list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
                    if(list.isNotEmpty){
                      return ListView.builder(
                        itemCount: isSearch ? searchList.length : list.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ChatCard(user: isSearch ? searchList[index] : list[index],);
                        },
                      );
                    } else {
                      return const Center(child: Text('No Data Found!',style: TextStyle(fontSize: 26),),);
                    }
                }
              },
            )
        ),
    );
  }
}
