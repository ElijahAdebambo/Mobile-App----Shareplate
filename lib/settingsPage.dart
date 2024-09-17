import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginPage.dart';
// implemented using pub.dev
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isDarkMode = false;
  bool isLargeText = false;
  bool isColorInvert = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark mode'),
            value: isDarkMode,
            onChanged: (bool value) {
              setState(() {
                isDarkMode = value;
              });

            },
          ),
          SwitchListTile(
            title: Text('Large Text'),
            value: isLargeText,
            onChanged: (bool value) {
              setState(() {
                isLargeText = value;
              });

            },
          ),
          SwitchListTile(
            title: Text('Colour Invert'),
            value: isColorInvert,
            onChanged: (bool value) {
              setState(() {
                isColorInvert = value;
              });

            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await _signOut(context);
            },
            child: Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyLoginPage(title: '')),
    );
  }
}
