import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Forgot_Password.dart';
import 'package:myapp/main.dart';
import 'package:myapp/signup.dart';
import 'package:myapp/textfield.dart';


class Login extends StatefulWidget{
  const Login({super.key});

  @override
  State<Login> createState() => _MyAppState();
}

class _MyAppState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey= GlobalKey<FormState>();


  @override
  Widget build(BuildContext context){
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 60,),
                Container(
                  alignment: Alignment.center,
                  padding: const  EdgeInsets.all(20),
                  height: 250,
                  width: 300,
                  child :
                  Image.asset('images/log.png'),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20),
                  child: EmailV(controller: _emailController,title: 'Email'),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: PaswordVal(text: 'Password',obscuretext: true,controller: _passwordController),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 220),
                  child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen(),));
                  },
                      child: const Text('Forgot Password'),),
                ),
                const SizedBox(height: 10),
                InkWell (
                  onTap: () async{
                    final form = _formKey.currentState!;
                    if(form.validate()){
                      try{
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((value) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder : (context) =>const Myapp()));
                        });
                      } on FirebaseAuthException catch(e){
                        print(e);
                        DialogAlert().dialog('Error',e.message!, context);
                      }
                    }
                  },
                  child : Padding(
                    padding: const EdgeInsets.only(left: 120,right: 120),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: const Text('Log in',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              height: 1.5,fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.center
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 60,left: 150),
                  child:
                  const Text('New User ?',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup()));},
                  child : Container(
                    margin: const EdgeInsets.only(right: 100,left: 100,top: 10),
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: const Text('Click Here',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            height: 1.5,fontWeight: FontWeight.w500
                        ),
                        textAlign: TextAlign.center,
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

class Progres {
  void showProgressBar(BuildContext context) {
    showDialog(context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()));
  }
}

class DialogAlert{
  void dialog(String title,String subTitle,BuildContext context){
    showDialog(context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Text(title),
              const SizedBox(width: 5,),
              const Icon(Icons.warning_amber_sharp,color: Colors.red,)
            ],
          ),
          content: Text(subTitle),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            },
              child: const Text('Ok',style: TextStyle(fontSize: 20)),),
          ],
        );
      },);
  }
}