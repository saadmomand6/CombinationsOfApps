import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:combinationsofapps/main.dart';
import 'package:combinationsofapps/todo/addtask.dart';
class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: const Text("Todo App",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: const Color.fromARGB(255, 228, 252, 14),
      ),
      body: const TasksScreen(),
    );
  }
}
// =================task structure=============
class Task{
  late String name;
  late bool isdone;
  Task({required this.name, this.isdone = false});
  void donetogle(){
    isdone = !isdone;
  }
}
// =================task structure ends=============
// =================task screen =============
class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(context: context, builder: (context) => const AddTasks());
        },
        backgroundColor: const Color(0xFF0A0E21),
        child: const  Icon(Icons.add,color: Color.fromARGB(255, 228, 252, 14),),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, right: 30, left: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(backgroundColor: Colors.white,radius: 30,child: Icon(
                  Icons.list,size: 38,color: Color(0xFF0A0E21),),),
                const SizedBox(height: 10,),
                const Text("TODOAPP",
                style: TextStyle(
                  color: Color.fromARGB(255, 228, 252, 14),
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),),
                Text("${Provider.of<Taskdata>(context).tasks.length} tasks",
                style: const  TextStyle(color: Color.fromARGB(255, 228, 252, 14),fontSize: 15),)
              ],
            ),
          ),
          Expanded(child: Container(
            decoration: const BoxDecoration(color: Colors.white,
            //borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            child: const Padding(
              padding:  EdgeInsets.all(18.0),
              child: Tasklist(),
              ),
            ),
          )
        ],
        
      ),
      
    );
  }
}
// =================task screen ends=============
// =================taskkists=============
class Tasklist extends StatelessWidget {
  const Tasklist({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Taskdata>(
       builder: (context, taskdata, child) {
      return ListView.builder(
        itemBuilder:(context, index) {
          return ListItem(
          tasktext: taskdata.tasks[index].name, 
          ischecked: taskdata.tasks[index].isdone, 
          callback: (newvalue){
            taskdata.updatetask(taskdata.tasks[index]);
          } , 
          deletecallback: (){
             taskdata.deletetask(taskdata.tasks[index]);
          } 
          );
          },
          itemCount: taskdata.tasks.length,
      );
       }
    );
      }
  }
class ListItem extends StatelessWidget {
  final bool ischecked;
  final String tasktext;
  final Function(bool?) callback; 
  final Function()? deletecallback;
  const ListItem({required this.tasktext,required  this.ischecked,required this.callback,required this.deletecallback, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(tasktext,style: TextStyle(decoration: ischecked ? TextDecoration.lineThrough : null )),
      trailing: Checkbox(
        activeColor: const Color.fromARGB(255, 228, 252, 14),
        value: ischecked, 
        onChanged: callback,
        
        ),
        onLongPress: deletecallback,
    );
  }
}
// =================tasklists ends=============
