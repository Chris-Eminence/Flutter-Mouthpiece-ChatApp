import 'package:flutter/material.dart';
import 'package:mouthpiece/screens/welcome_screen.dart';
import 'package:mouthpiece/screens/login_screen.dart';
import 'package:mouthpiece/screens/registration_screen.dart';
import 'package:mouthpiece/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          //body1: TextStyle(color: Colors.black54),
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        'login_screen': (context) => LoginScreen(),
        'register_screen': (context) => RegistrationScreen(),
        'chat_screen': (context) => ChatScreen(),
      },
    );
  }
}
