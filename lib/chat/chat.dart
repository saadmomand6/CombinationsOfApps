import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User? loggedinuser;
  final messageTextController = TextEditingController();
  String? messagetext;
  
  @override
  void initState() {
    super.initState();
    getcurrentuser();
  }
  void getcurrentuser(){
    try {
      final user = _auth.currentUser;
      // ignore: unnecessary_null_comparison
      if(User!=null){
         loggedinuser = user;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            _auth.signOut();
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.close,color: Color(0xFF0A0E21),),)
        ],
        title: const Text('⚡️Chat',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: const Color.fromARGB(255, 228, 252, 14),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder(
              stream: _firestore.collection("messages").orderBy('timestamp',descending: false).snapshots(),
              builder:  (context,AsyncSnapshot snapshot) {
                if(!snapshot.hasData){
                   // ignore: avoid_print
                print("no msg send");
                }else if(/*snapshot != null &&*/ snapshot.hasData && snapshot.data.docs != null){
                  final messages = snapshot.data.docs.reversed;
                  List<MessageBubble> messageBubbles = [];
                  for(var msg in messages){
                  final messageText = msg.data()["text"];
                  final messageSender = msg.data()["sender"];
                  final currentuser = loggedinuser?.email;
                  final msgBubble = MessageBubble(
                    sender: messageSender, 
                    text: messageText,
                    isme: currentuser == messageSender,
                    );
                  messageBubbles.add(msgBubble);
                  
                }
                return Expanded(
                  child: ListView(
                    reverse: true ,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    children: messageBubbles,
                  ),
                );
                
                }
                return Column();
                
            } 
            ),
            Container(
              decoration: const BoxDecoration(
  border: Border(
    top: BorderSide(color: Color.fromRGBO(254, 237, 0, 1), width: 2.0),
  ),
),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color:  Color.fromRGBO(254, 237, 0, 1)),
                      controller: messageTextController,
                      onChanged: (value) {
                         messagetext = value;
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          hintText: 'Type your message here...',
                          hintStyle: TextStyle(color: Color.fromRGBO(254, 237, 0, 1)),
                          border: InputBorder.none,
                          ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                     _firestore.collection("messages").add({
                      "text": messagetext,
                      "sender": loggedinuser?.email,
                      'timestamp': FieldValue.serverTimestamp(),
                     });
                    },
                    child:const Text(
                      'Send',
                      style: TextStyle(
                          color: Color.fromRGBO(254, 237, 0, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
    );
  }
}
class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isme;
  const MessageBubble({
    super.key,
     required this.sender,
    required this.text,
    required this.isme,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
     padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isme? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
        Text(sender,style: const  TextStyle(fontSize: 12,color: Color.fromARGB(255, 230, 221, 143)),),
        Material(
          borderRadius: isme? const BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30), 
            bottomRight: Radius.circular(30)): const  BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30), 
            bottomRight: Radius.circular(30)),
          elevation: 5,
          color: isme? const Color.fromRGBO(254, 237, 0, 1) : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Text(text,style: const TextStyle(fontSize: 15,color: Colors.black),),
          ),
        )
      ],),
      );
  }
}