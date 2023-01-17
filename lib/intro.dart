import 'package:flutter/material.dart';
import 'package:combinationsofapps/piano/piano.dart';
import 'package:combinationsofapps/dice/dice.dart';
import 'package:combinationsofapps/quiz/quiz.dart';
import 'package:combinationsofapps/bmi/bmi.dart';
import 'package:combinationsofapps/crypto/crypto.dart';
import 'package:combinationsofapps/todo/todo.dart';
import 'package:combinationsofapps/weather/weather.dart';
import 'package:combinationsofapps/chat/chat.dart';
class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: const Center(
          child: Text("My Apps",style: TextStyle(color: Colors.black),),
       ),
        
        backgroundColor: const Color.fromARGB(255, 228, 252, 14),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
               color: Color.fromARGB(255, 101, 123, 150)),
                child: 
                    Column(
                      children: [
                        const  SizedBox(height: 10,),
                         ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                           child: const  Image(
                             image: AssetImage("assets/profilepic.jpg"),width: 100,height: 100,),
                         ),
                          //CircleAvatar(backgroundImage: AssetImage("profilepic.jpg"),radius: 80,),
                    const Padding(padding: EdgeInsets.all(15),
                    child: Text("Mohammad Saad khan",
                    style: TextStyle(
                      color:  Color.fromARGB(255, 228, 252, 14), fontSize: 30, fontWeight: FontWeight.bold),),),
                       const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text("Hello! I'm Delightful to have you on my app. I am Mohammad Saad , I am studying BS in Software Engineering. I am flutter developer and have built following apps",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:   Color.fromARGB(255, 228, 252, 14),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ],
                    ),
              ),
            ),
            const SizedBox(height: 30,),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Myapps(
                    tittle: "Piano App",
                    icon: Icons.piano_rounded,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>const PianoApp()));
                    },
                  ),
                ),
                //const SizedBox(width: 10,),
                Expanded(
                  flex: 1,
                  child: Myapps(
                    tittle: "Dice App",
                    icon: Icons.casino_outlined,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const  DiceApp()));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Myapps(
                    tittle: "Quiz App",
                    icon: Icons.quiz_outlined,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizApp()));
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Myapps(
                    tittle: "BMI App",
                    icon: Icons.monitor_weight_outlined,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>const BmiApp()));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Myapps(
                    tittle: "Crypto App",
                    icon: Icons.currency_bitcoin_sharp,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>const CryptoApp()));
                    },
                  ),
                ),Expanded(
                  flex: 1,
                  child: Myapps(
                    tittle: "weatherApp",
                    icon: Icons.cloudy_snowing,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>const WeatherApp()));
                    },
                  ),
                ),
                
              ],
            ),
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Myapps(
                    tittle: "TODO App",
                    icon: Icons.checklist_outlined,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>const TodoApp()));
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Myapps(
                    tittle: "Chat App",
                    icon: Icons.chat_bubble_outline_rounded,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatApp()));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Myapps extends StatelessWidget {
  final IconData? icon;
  final String tittle;
  final VoidCallback? onPressed;
  const Myapps({
    required this.icon,
    required this.tittle,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration:  BoxDecoration(
          color: const Color.fromARGB(255, 101, 123, 150),
           border: Border.all(color: Colors.black, width: 2),
           borderRadius: BorderRadius.circular(20),
           boxShadow: const [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
      Icon(icon,size: 50,color: const Color.fromARGB(255, 228, 252, 14),),
      Text(tittle, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color:  Color.fromARGB(255, 228, 252, 14),),),
            ],
          ),
        ),
      ),
    );
  }
}