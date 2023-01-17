import 'package:flutter/material.dart';
import 'package:combinationsofapps/signedin/login.dart';
import 'package:combinationsofapps/signedin/registration.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}
class _WelcomePageState extends State<WelcomePage>  with SingleTickerProviderStateMixin{
  late AnimationController _controllerr;
   late Animation textanimation;  
  late Animation coloranimation;
  @override
  void initState() {
    super.initState();
    _controllerr = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      upperBound: 1.0,);
  textanimation= CurvedAnimation(parent: _controllerr, curve: Curves.bounceOut);
  coloranimation= ColorTween(begin: const Color.fromARGB(255, 255, 255, 255),
                            end: const Color(0xFF0A0E21),).animate(_controllerr);
  _controllerr.forward();
  _controllerr.addListener(() {setState(() {
    
  });});


  }
  @override
  void dispose() {
    _controllerr.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: coloranimation.value,
      appBar: AppBar(
        title: const Center(
          child: Text("Saad Khan Momand",style: TextStyle(color: Colors.black, )
       ),
        ),
        backgroundColor: const Color.fromARGB(255, 228, 252, 14),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:  [
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children:  [
                const  Hero(
                  tag: 'profilepic',
                  child: CircleAvatar(backgroundImage: AssetImage("assets/profilepic.jpg"),radius: 35,),
                  //child: Image(image: AssetImage("assets/profilepic.jpg"),width: 80,height: 80,)
                  ),
                const SizedBox(width: 10,),
                Text('Welcome To My App',style: TextStyle(
                         fontSize: textanimation.value*28,
                         color: const Color.fromARGB(255, 228, 252, 14),
                         fontWeight: FontWeight.w900,
                            ),),
               
               ],
             ),
             const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:80),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(12),),
            backgroundColor: const Color.fromARGB(255, 228, 252, 14),
              ), 
              child: const Text("Login To Your Account",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:80),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegistrationPage()));
              }, 
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: const Color.fromARGB(255, 228, 252, 14),
              ),
              child: const Text("Get Register",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),),
          ),
          
             

        ],
      ),
      );
  }
}