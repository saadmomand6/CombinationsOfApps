import 'package:flutter/material.dart';
import 'package:combinationsofapps/intro.dart';
import 'package:firebase_auth/firebase_auth.dart';
class RegistrationPage extends StatefulWidget {
  
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         const Center(child:  Text("Get Registered", style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 228, 252, 14),),)),
         //const  Hero(tag: 'profilepic', child: CircleAvatar(backgroundImage: AssetImage("assets/profilepic.jpg")),),
         const SizedBox(height: 35,),
          Container(
          color: Colors.transparent,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          width: 700,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value){
                email = value;
            },
            style: const TextStyle(
                      color: Color.fromARGB(255, 228, 252, 14),
                    ),
            decoration: const InputDecoration(
              hintText: "Enter Your Email",
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 228, 252, 14),
              ),
              enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 228, 252, 14),),
                      ),
              prefixIcon: Icon(
                        Icons.mail,
                        color: Color.fromARGB(255, 228, 252, 14),
                      ),
            ),
          ),
        ),
          const SizedBox(
                  height: 50,
                ),
        
          Container(
          color: Colors.transparent,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          width: 300,
          child: TextField(
            obscureText: true,
            onChanged: (value){
                password = value;
            },
            style: const TextStyle(
                      color: Color.fromARGB(255, 228, 252, 14),
                    ),
            decoration: const InputDecoration(
              hintText: "Enter Your Password",
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 228, 252, 14),
              ),
              enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 228, 252, 14),),
                      ),
              prefixIcon: Icon(
                        Icons.vpn_key_outlined,
                        color: Color.fromARGB(255, 228, 252, 14),
                      ),
            ),
          ),
        ),
          const SizedBox(height: 50,),
          Center(
          child: ElevatedButton(
            onPressed: () async{
                  try {
                    final newuser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    // ignore: unnecessary_null_comparison
                    if (newuser != null) {
                      if (!mounted) return;
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const IntroPage()));
                    }
                    
                  } catch (e) {
                    // ignore: avoid_print
                    print(e);
                  }
            },
            style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: const Color.fromARGB(255, 228, 252, 14),
                      ),
            child:const Text("Register",style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),)),
        )
        
        ],
      ),),
    );
  }
}