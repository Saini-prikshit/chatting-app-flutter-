import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar( backgroundColor: Colors.grey,
        title:const Padding(
        padding: EdgeInsets.only(left: 70),
        child: Text('Setting',style: TextStyle(fontSize: 28),
        ),
      ),
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 20,top: 20),
        child: Column(
          children: [
            Settings(text: 'Personal Information', icon: Icons.person_2),
            SizedBox(height: 20),
            Settings(text: 'Change Password', icon: Icons.password),
            SizedBox(height: 20),
            Settings(text: 'Notification', icon: Icons.notifications),
            SizedBox(height: 20),
            Settings(text: 'Privacy', icon: Icons.lock),
            SizedBox(height: 20),
            Settings(text: 'Help', icon: Icons.help_center),
            SizedBox(height: 20),
            Settings(text: 'About', icon: Icons.privacy_tip),
          ],
        ),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key,required this.text,required this.icon});
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Icon(icon,size: 40),
        Padding(
          padding: const EdgeInsets.only(left: 10,top: 10),
          child: Text(text,style: const TextStyle(fontSize: 22),),
        )
      ],
    );
  }
}
