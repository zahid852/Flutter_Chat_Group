import 'dart:developer';

import 'package:chat_group/pages/main_page.dart';
import 'package:chat_group/view_models/login_viewModel.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String _message = "";
  loginViewModel _viewModel = loginViewModel();
  final _usernameController = TextEditingController();

  void _login(BuildContext context) async {
    final username = _usernameController.text;

    // check if username is not empty
    if (username.isEmpty) {
      setState(() {
        _message = "Username cannot be empty!";
      });
    } else {
      log('hlo');
      final isLoggedIn = await _viewModel.login(username);
      log('hlo $isLoggedIn');
      // perform login

      // on successful login take the user to the main page
      if (isLoggedIn)
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
              maxRadius: 150,
              backgroundImage: AssetImage("assets/images/logo.png")),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _usernameController,
            decoration: InputDecoration(hintText: "Enter username"),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.grey),
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            _login(context);
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_message),
        )
      ]),
    ));
  }
}
