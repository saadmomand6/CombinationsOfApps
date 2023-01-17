import 'package:flutter/material.dart';
import 'dart:math';

class DiceApp extends StatefulWidget {
  const DiceApp({super.key});

  @override
  State<DiceApp> createState() => _DiceAppState();
}

class _DiceAppState extends State<DiceApp> {
  int leftDiceNumber = 6;
  int rightDiceNumber = 4;
  void changediceface() {
    setState(() {
    leftDiceNumber = Random().nextInt(6) + 1;  
    rightDiceNumber = Random().nextInt(6) + 1;
    });
  }
  @override
  Widget build(BuildContext context) {
    
  
    return Scaffold(
      appBar: AppBar(title: const Text("Dice App",style: TextStyle(color:  Color(0xFF0A0E21),),),backgroundColor: const Color.fromARGB(255, 228, 252, 14),),
      backgroundColor: const Color(0xFF0A0E21),
      body: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: () {
                   changediceface();
                  },
                  child: Image.asset('assets/dice$leftDiceNumber.png'),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    changediceface();
                  },
                  child: Image.asset('assets/dice$rightDiceNumber.png'),
                ),
              ),
            ],
          ),
        )
    
    );
    
  }
}