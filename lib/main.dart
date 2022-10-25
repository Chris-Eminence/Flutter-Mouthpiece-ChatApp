// @dart=2.9

import 'package:flutter/material.dart';
import 'package:mouthpiece/screens/welcome_screen.dart';
import 'package:mouthpiece/screens/login_screen.dart';
import 'package:mouthpiece/screens/registration_screen.dart';
import 'package:mouthpiece/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
