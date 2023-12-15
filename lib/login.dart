import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Forgot_Password.dart';
import 'package:myapp/main.dart';
import 'package:myapp/signup.dart';
import 'package:myapp/textfield.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _MyAppState();
}

class _MyAppState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLoading2 = false;
  User? user;

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 80,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                child: Padding(
                  padding: const EdgeInsets.only(right: 160),
                  child: Column(
                    children: [
                      Text(
                        'WelCome Back',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Text('Please login to continue',style: TextStyle(fontSize: 16),),
                      )
                    ],
                  ),
                ),
                // alignment: Alignment.center,
                // padding: const EdgeInsets.all(20),
                // height: MediaQuery.of(context).size.height * 0.30,
                // width: MediaQuery.of(context).size.width * 0.30,
                // child: Image.asset('images/log.png'),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: EmailV(controller: _emailController, title: 'Email'),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: PaswordVal(
                      text: 'Password',
                      obscuretext: true,
                      controller: _passwordController),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 220),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ));
                  },
                  child: const Text('Forgot Password'),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                splashColor: Colors.blue,
                onTap: () async {
                  final form = _formKey.currentState!;
                  if (form.validate()) {
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text)
                          .then((value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Myapp()));
                        setState(() {
                          isLoading = false;
                        });
                      });
                    } on FirebaseAuthException catch (e) {
                      print(e);
                      setState(() {
                        isLoading = false;
                      });
                      DialogAlert().dialog('Error', e.message!, context);
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.060,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('Please Wait...',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ],
                            )
                          : Text('Log in',
                              style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60, left: 150),
                child: const Text(
                  'New User ?',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isLoading2 = true;
                  });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Signup()));
                  setState(() {
                    isLoading2 = false;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 80, left: 80, top: 10),
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: isLoading2
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Please Wait...',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ],
                          )
                        : Text(
                            'Click Here',
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class DialogAlert {
  void dialog(String title, String subTitle, BuildContext context) {
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
      },
    );
  }
}
