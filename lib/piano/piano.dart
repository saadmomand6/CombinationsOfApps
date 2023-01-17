import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
class PianoApp extends StatefulWidget {
  const PianoApp({super.key});

  @override
  State<PianoApp> createState() => _PianoAppState();
}

class _PianoAppState extends State<PianoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        appBar: AppBar(
          title: const Text("Piano App",style: TextStyle(color:  Color.fromARGB(255, 228, 252, 14),),),
          backgroundColor: const Color(0xFF0A0E21),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
             Sound(
              text: "1",
              color: Colors.yellow,
              number: 1,
            ),
             Sound(
              text: "2",
              color: Colors.orange,
              number: 2,
            ),
               Sound(
              text: "3",
              color: Colors.red,
              number: 3,
            ),
               Sound(
              text: "4",
              color: Colors.pink,
              number: 4,
            ),
               Sound(
              text: "5",
              color: Colors.purple,
              number: 5,
            ),
               Sound(
              text: "6",
              color: Colors.blue,
              number: 6,
            ),
               Sound(
              text: "7",
              color: Colors.green,
              number: 7,
            ),      
          ],
        ),
        );     
    
  }
}
class Sound extends StatelessWidget {
  final Color color;
  final String text;
  final int number;

  const Sound({
    Key? key,
    required this.color,
    required this.number,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: color,
        child: TextButton(
            onPressed: ()  {
              final player = AudioPlayer();
              player.play(AssetSource('note$number.mp3'));
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              ),
            child: Text(text,
            style: const TextStyle(fontSize: 60),),
            ),
      ),
    );
  }
}