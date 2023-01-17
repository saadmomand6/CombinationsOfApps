import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:combinationsofapps/intro.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    late String email;
    late String password;
    final auth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           const Center(child:  Text("Login To Your Account", style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 228, 252, 14),),)),
         //const  Hero(tag: 'profilepic', child: CircleAvatar(backgroundImage: AssetImage("assets/profilepic.jpg"),radius: 35,),),
         const SizedBox(height: 35,),
        Container(
          color: Colors.transparent,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          width: 300,
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
                    final user = await auth.signInWithEmailAndPassword(email: email, password: password);
                    // ignore: unnecessary_null_comparison
                    if (user != null) {
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
            child:const Text("Login",style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),)),
        )
        
        ],
      ),),
    );
  }
}