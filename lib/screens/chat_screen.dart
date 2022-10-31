import 'package:flutter/material.dart';
import 'package:mouthpiece/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

final _auth = FirebaseAuth.instance; //instance of Firebase Authentication
final _firesStore = FirebaseFirestore.instance; //instance of FirebaseFirestore
late User loggedInUser;
late String messageText;

  @override
  void initState() {
    super.initState();
    getNewUsers();
  }

void getNewUsers() async{
  try{
    final user = await _auth.currentUser;
    if (user != null ){
      loggedInUser = user;
      print(loggedInUser.email);
    }
  }catch(e){
    print (e);
  } 
}

// void getMessages() async {
//   final messages = await _firesStore.collection('messages').get(); //getting documents from FirestoreFirebase
//   // using for loop to get the messages from fireStore because colloections returns a list
//   for (var message in messages.docs){
//     print(message.data);
//   }
// }

void messagesStream() async {
  await for (var snapshots in _firesStore.collection('messages').snapshots()){
    for (var message in snapshots.docs){
      print (message.data);
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('💬Mouthpiece'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firesStore.collection('messages').snapshots(),
              
              builder: (context, snapshot){
                if (snapshot.hasData){
                  final messages = snapshot.data!.docs;
                  List<Text> messageWidgets = [];
                  for (var message in messages){
                    final messageText = message['text'];
                    // final messageText = message.data['text'];

                    final messageSender = message['sender'];
                    // final messageSender = message.data['sender'];

                    // final messageSender = message.get('sender'); this didn't return any error


                    final messageWidgets = Text('$messageText from $messageSender');
                    messageText.add(messageWidgets);

                  }
                  return Column(
                    children: messageWidgets,
                  );
                }
                throw '' ;
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      _firesStore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
