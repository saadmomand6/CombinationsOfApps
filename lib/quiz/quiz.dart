import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizbrain = QuizBrain();
class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF0A0E21),
        appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 252, 14),
        title: const  Center(
          child: Text('Quiz App',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body:const Padding(padding: EdgeInsets.symmetric(horizontal: 15),
      child: QuizerPage(),
      ),
      );
    
  }
}
class QuizerPage extends StatefulWidget {
  const QuizerPage({super.key});

  @override
  State<QuizerPage> createState() => _QuizerPageState();
}

class _QuizerPageState extends State<QuizerPage> {
  List<Icon> scorekeeper = [];
  int score=0;
  void checking(bool userpickedanswer){
    bool correctanswer = quizbrain.getquestionanswer();
    setState(() {
      if(quizbrain.isfinished()==true){
         Alert(
      context: context,
      type: AlertType.success,
      title: "Quiz Finished",
      desc: "You Got $score Out Of ${quizbrain.totalquestion()}",
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "TRY AGAIN",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
         quizbrain.reset();

      }else{
        if (userpickedanswer==correctanswer) {
          scorekeeper.add( Icon(Icons.check, color: Colors.green.shade100,));
                  score++;
        }else{
           scorekeeper.add(Icon(Icons.close, color: Colors.red.shade100,));
        }
        quizbrain.nextquestion();

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
         Expanded(
          flex: 5,
          child: Center(
            child: Text(quizbrain.getquestiontext(),textAlign: TextAlign.center,
              style: const  TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 101, 123, 150),
              ),),)),
        Expanded(child: Padding(padding: const EdgeInsets.all(15),
        child: TextButton(
          style: TextButton.styleFrom(
                textStyle: const TextStyle(color: Colors.white,),
                backgroundColor: Colors.green,
              ),
          onPressed: () {
            checking(true);
          }, 
          child: const Text("TRUE", style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),)),)),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(15),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                textStyle: const TextStyle(color: Colors.white,),
              ),
              onPressed: (){
                checking(false);
              }, 
              child: const Text("FALSE",style: TextStyle(color: Colors.white, fontSize: 20),)),
          ),),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                
                children: scorekeeper,
                ),
            ),
            const SizedBox(
              height: 40,
            )

      ],
    );
  }
}

class Question{
  late String questiontext;
  late bool anwser;
  Question(String q, bool a){
    questiontext=q;
    anwser=a;
  }
}

class QuizBrain{
  int questionNumber = 0;
 final List<Question> allquestions =[
    Question('Sharks are mammals', false),
    Question('The hummingbird egg is the world\'s smallest bird egg',true),
    Question('Bats are blind', false),
    Question('An octopus has seven hearts.', false),
    Question('The goat is the national animal of Scotland.', false),
    Question('South Africa has one capital.', false),
    Question('The Atlantic Ocean is the biggest ocean on Earth.',false),
    Question('You can find the "Desert of Death" in California.', false),
    Question('The total length of the Great Wall of China adds up to 13,171 miles.', true),
    Question( 'Venezuela is home to the world\'s highest waterfall.', true),
    Question( 'Most of the human brain is made of muscle.', false),
    Question( 'Taste buds can only be found on the tongue.', false),
    Question( 'The human eye can distinguish 10 million different colors.',true),
    Question( 'The human body is about 60% water.', true),
    Question( 'The most common blood type is 0- negative.',true),
    Question( 'Pineapples grow on trees.', false),
    Question( 'French fries originated from France.',false),
    Question( 'Polo takes up the largest amount of space in terms of land area.', true),
    Question( 'Brazil is the only nation to have played in every World Cup finals tournament.', true),
    Question( 'Every golf ball has the same number of dimples.',  false),
    Question( 'The letter “T” is the most common in the English Language.', false),
    Question( 'All the kings in a standard deck of cards have a mustache.', false),
    Question( 'Pepsi was the first soft drink to be enjoyed in outer space.', false),
    Question( 'Herbivores are animal eaters.', false),
    Question( 'New York City is composed of between 36 and 42 islands.', true),
  ];
void nextquestion(){
  if (questionNumber < allquestions.length -1){
    questionNumber++;
  }
}
String getquestiontext(){
  return allquestions[questionNumber].questiontext;
}
bool getquestionanswer(){
  return allquestions[questionNumber].anwser;
}
int totalquestion(){
  return allquestions.length;
 }
void reset(){
  questionNumber =0;
 }
 bool isfinished(){
  if(questionNumber==allquestions.length-1){
    return true;
  }else{
    return false;
  }
 }
}