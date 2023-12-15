import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class TextF extends StatefulWidget {
  const TextF({super.key,required this.label, this.controller,required this.icon,required this.obscureText});
   final String label;
   final IconData icon;
   final TextEditingController? controller;
   final bool obscureText;

  @override
  State<TextF> createState() => _TextFState();
}

class _TextFState extends State<TextF> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      obscureText: widget.obscureText,
      controller: widget.controller,
       decoration: InputDecoration(
         prefixIcon: Icon(widget.icon,color: Colors.black),
         filled: true,
         fillColor: Colors.white,
         labelText: widget.label,
         labelStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
         border: OutlineInputBorder(borderRadius: BorderRadius.circular(50),),
         focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,width: 1.5),borderRadius: BorderRadius.circular(50))
       ),
    );
  }
}


class EmailV extends StatefulWidget {
  const EmailV({super.key, required this.controller, required this.title});
  final TextEditingController controller;
  final String title;
  @override
  State<EmailV> createState() => _EmailVState();
}

class _EmailVState extends State<EmailV> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.black,
      controller: widget.controller,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email,color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          labelText: widget.title,
          labelStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50),),
          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,width: 1.5),borderRadius: BorderRadius.circular(50))
      ),
      validator: (email) => email != null && !EmailValidator.validate(email) ? 'Enter a valid Email' : null,
    );
  }
}


class PaswordVal extends StatefulWidget {
  const PaswordVal({super.key, required this.controller, required this.obscuretext, required this.text});
  final TextEditingController controller;
  final bool obscuretext;
  final String text;
  @override
  State<PaswordVal> createState() => _PaswordValState();
}

class _PaswordValState extends State<PaswordVal> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      cursorColor: Colors.black,
      obscureText: widget.obscuretext,
      controller: widget.controller,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock,color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          labelText: widget.text,
          labelStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50),),
          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,width: 1.5),borderRadius: BorderRadius.circular(50))
      ),
      validator: (value) {
        if(value == null || value.isEmpty){
          return 'Please enter password';
        } else if(value.length<6){
          return 'Password should be greater than 6';
        } else{
          return null;
        }
      },
    );
  }
}

class NameVal extends StatefulWidget {
  const NameVal({super.key, required this.controller, required this.text});
  final TextEditingController controller;
  final String text;
  @override
  State<NameVal> createState() => _NameValState();
}

class _NameValState extends State<NameVal> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      cursorColor: Colors.black,
      controller: widget.controller,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person,color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          labelText: widget.text,
          labelStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50),),
          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,width: 1.5),borderRadius: BorderRadius.circular(50))
      ),
      validator: (value) {
        if(value == null || value.isEmpty){
          return 'Please Enter Name';
        } else{
          return null;
        }
      },
    );
  }
}
