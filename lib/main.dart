import 'package:chat_group/firebase_options.dart';
import 'package:chat_group/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Lets Chat",
        theme: ThemeData(primaryColor: const Color(0xFF27ae60)),
        home: LoginPage());
  }
}
