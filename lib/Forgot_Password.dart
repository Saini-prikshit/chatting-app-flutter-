import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/login.dart';
import 'package:myapp/textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Image.asset('images/forgot-password.png',
                height: 160, width: 180, alignment: Alignment.topCenter),
            const SizedBox(height: 50),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    EmailV(
                        controller: _emailController,
                        title: 'Registered Email'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.55,
              child: ElevatedButton(
                onPressed: () async {
                  final form = _formKey.currentState!;
                  if (form.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _emailController.text)
                          .then((value) => showSnackBarFun(
                              context, 'Link has been sent to your email'))
                          .then((value) => Navigator.pop(context));
                      setState(() {
                        isLoading = false;
                      });
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        isLoading = false;
                      });
                      DialogAlert().dialog('Error', e.message!, context);
                    }
                  }
                },
                child: Center(
                    child: isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Please Wait...',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )
                            ],
                          )
                        : Text(
                            'Submit',
                            style: TextStyle(fontSize: 23),
                          )),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  backgroundColor: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showSnackBarFun(context, String title) {
  SnackBar snackBar = SnackBar(
    content:
        Text(title, style: const TextStyle(color: Colors.black, fontSize: 20)),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.white,
    duration: const Duration(seconds: 3),
    dismissDirection: DismissDirection.up,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    margin: const EdgeInsets.only(bottom: 715, left: 20, right: 20),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
