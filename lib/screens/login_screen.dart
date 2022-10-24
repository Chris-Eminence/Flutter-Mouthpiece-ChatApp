import 'package:flutter/material.dart';
import 'package:mouthpiece/components/rounded_button.dart';
import 'package:mouthpiece/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import  'chat_screen.dart';



class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo_transition',
              child: SizedBox(
                height: 400.0,
                child: Image.asset('images/mouth_piece_icon.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email')),
            const SizedBox(
              height: 8.0,
            ),
            TextField(       
              obscureText: true,       
              textAlign: TextAlign.center,
              keyboardType: TextInputType.visiblePassword,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password')),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                onPressed: () async {
                  //Implement Login Functionality here
                  try{
                  final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if (user != null){
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  }catch(e){
                    print (e);
                  }
                },
                title: 'Login',
                color: Colors.lightBlueAccent)
          ],
        ),
      ),
    );
  }
}
