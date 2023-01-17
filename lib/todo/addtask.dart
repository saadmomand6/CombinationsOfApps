import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:combinationsofapps/main.dart';

class AddTasks extends StatelessWidget {
   const  AddTasks({super.key});
    

  @override
  Widget build(BuildContext context) {
    late String newtasktext;
    return Container(
      height: 700,
      padding: const EdgeInsets.all(18.0),
      decoration: const BoxDecoration(
        color:  Color(0xFF0A0E21),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("ADD TASK",
          textAlign: TextAlign.center,
          style: TextStyle(
            
            color: Color.fromARGB(255, 228, 252, 14),
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 228, 252, 14),),
                    ),
            ),
            onChanged: (newvalue) {
              newtasktext = newvalue;       
            },
            
          ),
          const SizedBox(
                height: 50,
              ),
          ElevatedButton(
            onPressed: (){
              
             Provider.of<Taskdata>(context,listen: false).addTask(newtasktext);         
            Navigator.pop(context);
          }, 
          style:  ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(12),),
            backgroundColor: const Color.fromARGB(255, 228, 252, 14),

          ), 
          child: const Text("ADD",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),)
        ],
      ),
    );
  }
}