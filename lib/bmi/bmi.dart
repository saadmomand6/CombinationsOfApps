import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
const Color mycolor= Color.fromARGB(255, 101, 123, 150);
const inactivecardcolor = Color.fromARGB(255, 101, 123, 150);
const activecardcolor= Color.fromARGB(255, 40, 51, 65);
enum Gender{male,female}
class BmiApp extends StatefulWidget {
  const BmiApp({super.key});

  @override
  State<BmiApp> createState() => _BmiAppState();
}

class _BmiAppState extends State<BmiApp> {
  int height =180;
  int weight = 65;
  int age= 21;
  Gender? selectedgender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
       appBar: AppBar(title: const Text("BMI App",style: TextStyle(color:  Color(0xFF0A0E21),),),backgroundColor: const Color.fromARGB(255, 228, 252, 14),),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedgender = Gender.male;
                        });
                      },
                      child: Reuseablecard(
                        color: selectedgender==Gender.male ? activecardcolor : inactivecardcolor, 
                        cardchild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(FontAwesomeIcons.mars,
                      size: 30,
                      color: Color.fromARGB(255, 228, 252, 14),),
                      SizedBox(
                        height: 10,
                      ),
                      Text('MALE',
                      style: TextStyle(fontSize: 20,
                      color: Color.fromARGB(255, 228, 252, 14)),
                      )
                          ],
                        ),
                        
                        ),
                    )),
                  Expanded(
                    child: GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedgender = Gender.female;
                          });
                        },
                        child: Reuseablecard(
                          color: selectedgender==Gender.female ? activecardcolor : inactivecardcolor, 
                          cardchild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(FontAwesomeIcons.venus,
                        size: 30,
                        color: Color.fromARGB(255, 228, 252, 14),),
                        SizedBox(
                          height: 10,
                        ),
                        Text('FEMALE',
                        style: TextStyle(fontSize: 20,
                        color: Color.fromARGB(255, 228, 252, 14)),
                        )
                            ],
                          ),
                          
                          ),
                      )),
                  
                ],
              ),
              
            ),
            SingleChildScrollView(
            child: Expanded(
              child: Reuseablecard(
                color: mycolor,
                cardchild: Column(
                  children: [
                    const Text('HEIGHT',
                    style: TextStyle(fontSize: 20,
                            color: Color.fromARGB(255, 228, 252, 14)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                         Text(height.toString(),
                    style:const TextStyle(fontSize: 50,
                    fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 228, 252, 14)),
                    ),
                    const Text('cm',
                    style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 228, 252, 14)),
                    ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const  Color.fromARGB(255, 140, 174, 182),
                        inactiveTrackColor: const Color(0xFF0A0E21),
                        thumbShape:const RoundSliderThumbShape(enabledThumbRadius: 12),
                        thumbColor:const Color.fromARGB(255, 228, 252, 14),
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
                        overlayColor: const  Color.fromARGB(255, 140, 174, 182),
                      ),
                      child: Slider(
                        value: height.toDouble(), 
                        min: 100,
                        max: 200,
                        onChanged: (double myheightvalue){
                          setState(() {
                            height =myheightvalue.round();
                          });
                        }),
                    ),
                      const SizedBox(
                        height: 5,
                      )
                      ]
                )
              ),
            ),
          ),
          Expanded(
            child: Row(
                children:  [
                Expanded(
                  child: SingleChildScrollView(
                    child: Reuseablecard(
                      cardchild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Weight',style: TextStyle(fontSize: 20,
                            color: Color.fromARGB(255, 228, 252, 14)), ),
                          Text(weight.toString(),
                          style:const TextStyle(fontSize: 50,
                    fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 228, 252, 14)),
                          
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                                RoundIconButton(
                                 icon: FontAwesomeIcons.minus,
                                 onPressed: () {
                                   setState(() {
                                     weight--;
                                   });
                                 },
                                 ),
                                 
                               const SizedBox(
                                  width: 40,
                                ),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: (){
                                    setState(() {
                                  weight++;
                                 });
                                  }
                                
                                ),
                            ],
                          ),
                        ],
                      ),
                      color: mycolor),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Reuseablecard(
                      cardchild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('AGE',style: TextStyle(fontSize: 20,
                            color: Color.fromARGB(255, 228, 252, 14)), ),
                          Text(age.toString(),
                          style:const TextStyle(fontSize: 50,
                    fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 228, 252, 14)),
                          
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                                RoundIconButton(
                                 icon: FontAwesomeIcons.minus,
                                 onPressed: () {
                                   setState(() {
                                     age--;
                                   });
                                 },
                                 ),
                                 
                               const SizedBox(
                                  width: 40,
                                ),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: (){
                                    setState(() {
                                  age++;
                                 });
                                  }
                                
                                ),
                            ],
                          ),
                        ],
                      ),
                      color: mycolor),
                  ),
                ),
              ],
              
            ),
            
            ),
            GestureDetector(
              onTap: () {
                Bmibrain calc = Bmibrain(height, weight);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  ResultPage(
                  bmiresult: calc.calculate(),
                  gettext: calc.getresult(),
                  getadvice: calc.getadvice(),
                )
                ));
              },
              child: Container(
                 color: const Color.fromARGB(255, 228, 252, 14),
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(bottom: 20),
                height: 60,
                child: const Center(
                  child: Text("CALCULATE",style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),
                ),
              ),),
          ],
        ),
    );
  }
}
//==========================widegets

class Reuseablecard extends StatelessWidget {

  final Color color;
  final Widget? cardchild;

  const Reuseablecard({
    this.cardchild,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: cardchild,
    );
  }
}
class RoundIconButton extends StatelessWidget {

  final IconData? icon;
  final VoidCallback? onPressed;

  const RoundIconButton({
    required this.icon,
    this.onPressed,
    super.key});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      fillColor: const Color.fromARGB(255, 251, 255, 0),
      elevation: 9,
      constraints: const BoxConstraints.tightFor(
            width: 45.0,
            height: 45.0,
          ),
      
      
      onPressed: onPressed,
      child: Icon(icon, color: const Color.fromARGB(255, 5, 31, 53),));
  }
}
//==========================widegets


//==========================brain
class Bmibrain {
  final int weight;
  final int height;

  Bmibrain( this.height,  this.weight);

  late final double _bmi;

  String calculate() {
     _bmi = (weight / height / height) * 10000;
   // _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

   getresult() {
    if(_bmi<18.5){
      return 'Underweight';
    }else if(_bmi>=18.5 && _bmi<=24.5){
      return 'Normal weight';
    }else if(_bmi>24.5) {
      return 'Over weight';

    }
  }
  getadvice() {
    if(_bmi<18.5){
      return 'You have lower then normal body weight! try to eat more';
    }else if(_bmi>=18.5 && _bmi<=24.5){
      return 'You have a normal body weight good job';
    }else if(_bmi>24.5) {
      return 'You have higher weight! try to do more exercise';

    }
  }
}
//==========================brain


//========================result page

class ResultPage extends StatelessWidget {
  
  
  final String bmiresult;
  final String gettext;
  final String getadvice; 

  const ResultPage({
    required this.bmiresult,
    required this.gettext,
    required this.getadvice,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: const Text('BMI Calculator App',style: TextStyle(color:  Color(0xFF0A0E21),),),
        backgroundColor: const Color.fromARGB(255, 228, 252, 14),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
           Expanded(child: Container(
            padding:const EdgeInsets.all(10),
            alignment: Alignment.bottomLeft,
            child:const Text('YOUR RESULT IS HERE',
            style: TextStyle(
              color:  Color.fromARGB(255, 228, 252, 14),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),),
          )),
          Expanded(
            flex: 5,
            child: Reuseablecard(
              color: mycolor,
              cardchild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(gettext.toUpperCase(),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 37, 248, 150),
                    fontSize: 40,
                  ),),
                   Text(bmiresult,
                  style: const TextStyle(
                    color:  Color.fromARGB(255, 228, 252, 14),
                    fontSize: 60,
                  ),),
                   Text(getadvice,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color:  Color.fromARGB(255, 228, 252, 14),
                    fontSize: 25,
                  ),),
                  

                ],
              ),
            
            
            ),
           

          ),
           GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                color: const Color.fromARGB(255, 228, 252, 14),
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(bottom: 20),
                height: 80,
                child: const Center(
                  child: Text('RE-CALCULATE',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),
                ),
              ),
            )
        ],
        )
      
      );
  }
}