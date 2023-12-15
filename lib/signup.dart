import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/API.dart';
import 'package:myapp/Home_page.dart';
import 'package:myapp/image_picker.dart';
import 'package:myapp/login.dart';
import 'package:myapp/main.dart';
import 'package:myapp/textfield.dart';


final nameController = TextEditingController();
final surnameController = TextEditingController();

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _handleGoogleSignin() {
    signInWithGoogle().then((value) async {
      if (await Apis.userExists()) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      } else {
        await Apis().createUser().then((value) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        });
      }
    });
  }

  _handleFb() {
    signInWithFacebook().then((value) async {
      if (await Apis.userExists()) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      } else {
        await Apis().createUser().then((value) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        });
      }
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? user = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? auth = await user?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: auth?.accessToken,
        idToken: auth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      _dialog('Error', e.message!, context);
      return null;
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult fbLogin = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(fbLogin.accessToken!.token);
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      _dialog('Error', e.message!, context);
      return null;
    }
  }

  void _dialog(String title, String subTitle, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Row(
              children: [
                Text(title),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.warning_amber_sharp,
                  color: Colors.red,
                )
              ],
            ),
            content: Text(subTitle),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok', style: TextStyle(fontSize: 20)),
              ),
            ],
          );
        });
  }

  File? image;
  void galleryImage() async{
    image = await ImagesPicker().pickImageFromGallery(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 80),
                  child: const Text(
                    'Create New Account',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 75),
                      child: Column(
                        children: [
                          Stack(children: [
                            image == null ? CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 100,
                                )) : CircleAvatar(
                                radius: 60,
                              backgroundImage: FileImage(image!),
                                ) ,
                            Positioned(
                                child: IconButton(
                                  onPressed: () {
                                    galleryImage();
                                  },
                                  icon: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.black,
                                  ),
                                ),
                                bottom: 5,
                                left: 82),
                          ]),
                          const SizedBox(
                            height: 20,
                          ),
                          NameVal(
                              controller: nameController, text: 'First Name'),
                          const SizedBox(height: 15),
                          TextF(
                              label: 'Last Name',
                              controller: surnameController,
                              icon: Icons.person,
                              obscureText: false),
                          const SizedBox(height: 15),
                          EmailV(controller: _emailController, title: 'Email'),
                          const SizedBox(height: 15),
                          PaswordVal(
                              text: 'Password',
                              obscuretext: true,
                              controller: _passwordController),
                          const SizedBox(height: 25),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        backgroundColor: Colors.black),
                                    onPressed: () async {
                                      final form = _formKey.currentState!;
                                      if (form.validate()) {
                                        try {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: _emailController.text,
                                                  password:
                                                      _passwordController.text)
                                              .then((value) =>
                                                  Apis().createUsers())
                                              .then((value){
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Myapp(),
                                                ));
                                          });
                                          setState(() {
                                            isLoading = false;
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          print(e);
                                          setState(() {
                                            isLoading = false;
                                          });
                                          DialogAlert().dialog(
                                              'Error', e.message!, context);
                                        }
                                      }
                                    },
                                    child: Center(
                                        child: isLoading
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                      width: 25,
                                                      height: 25,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.white,
                                                      )),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    'Please Wait...',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  )
                                                ],
                                              )
                                            : Text('Sign up',
                                                style: TextStyle(
                                                    fontSize: 23,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                  ),
                                ),
                              ]),
                          SizedBox(
                            height: 40,
                          ),
                          Text('OR',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500)),
                          Padding(
                            padding: const EdgeInsets.only(top: 35, left: 5),
                            child: Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      _handleGoogleSignin();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(35)),
                                      minimumSize: Size(10, 50),
                                      backgroundColor:
                                          Color.fromRGBO(201, 7, 7, 0.90),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset('images/gg.png',
                                            height: 40),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Google  ',
                                          style: TextStyle(fontSize: 20),
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _handleFb();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                    minimumSize: Size(10, 50),
                                    backgroundColor: Colors.indigo,
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'images/f.png',
                                        height: 40,
                                      ),
                                      Text('facebook',
                                          style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
