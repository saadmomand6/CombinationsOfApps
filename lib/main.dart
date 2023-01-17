import 'package:flutter/material.dart';
import 'package:combinationsofapps/signedin/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:combinationsofapps/todo/todo.dart';
import 'package:provider/provider.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Taskdata(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  WelcomePage(),
      ),
    );
  }
}
class Taskdata extends ChangeNotifier{
  List<Task> tasks = [
      Task(name: "task1"),
      Task(name: "task2"),
      Task(name: "task3"),
      
    ];
  void addTask(String newtasktext) {
    final newtask = Task(name: newtasktext);
    tasks.add(newtask);
    notifyListeners();

  }
  void updatetask(Task task){
    task.donetogle();
    notifyListeners();

  }
  void deletetask(Task task){
    tasks.remove(task);
    notifyListeners();
  }
}