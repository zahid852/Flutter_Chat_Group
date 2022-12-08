import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  void _signOut() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.grey),
              child: Text(
                "Sign Out",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _signOut();
              },
            ),
          ]),
        ));
  }
}
