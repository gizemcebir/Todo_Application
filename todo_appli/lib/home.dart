import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_appli/add_new_task.dart';
import 'package:todo_appli/constants/tast_type.dart';
import 'package:todo_appli/model/task.dart';
import 'package:todo_appli/service/todo_service.dart';
import 'package:todo_appli/todo_item.dart';

import 'constants/color.dart';
import 'main.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  //List<String> todo = ["study lessons", "run SK", "Go to party"];
  //List<String> completed =["Game Meetup" , "Take Out Trash"];

  List<Task> todo = [
    Task(
        title: "study lessons",
        description: "study COMP117",
        isCompleted: false,
        type: TaskType.note
    ),
    Task(
        title: "Go to party",
        description: "attend to party",
        isCompleted: false,
        type: TaskType.calendar
    ),
    Task(
        title: "run SK",
        description: "run 5 kilometers",
        isCompleted: false,
        type: TaskType.contest
    ),
  ];

  List<Task> completed = [
    Task(
        title: "Go to party",
        description: "attend to party",
        isCompleted: false,
        type: TaskType.calendar
    ),
    Task(
        title: "run SK",
        description: "run 5 kilometers",
        isCompleted: false,
        type: TaskType.contest
    ),
  ];

  void addNewTask(Task newTask){
   setState(() {
     todo.add(newTask);
   });
  }
  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService();
    double deviceHeight = MediaQuery.of(context).size.height ;
    double deviceWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(backgroundColor),
          body: Column(children: [
            // header
            Container(
              width: deviceWidth,
              height: deviceHeight / 3,
              color : Colors.purple,
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "october 20 , 2022" ,
                      style: TextStyle(
                          color: Colors.white ,
                          fontSize: 18 ,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 50) ,
                      child:  Text(
                        "My Todo List",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35 ,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  )
                ],
              ),
            ),
            //top column
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: SingleChildScrollView(
                  child: FutureBuilder(
                      future: todoService.getUncompletedTodos(),
                      builder: (context,snapshot){
                        print(snapshot.data);
                        if(snapshot.data == null){
                          return const CircularProgressIndicator();
                        }
                        else{
                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index){
                              return todoitem(
                                task: snapshot.data![index],
                              );
                            },
                          );
                        }
                      },
                  )
                ),
              ),
            ),
            //completed text
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child:  Align(
                alignment: Alignment.centerLeft,
                child: Text("completed",
                  style: TextStyle(
                      fontWeight:FontWeight.bold,
                      fontSize: 18 ),
                ),
              ),
            ),
            //bottom column
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: SingleChildScrollView(
                    child: FutureBuilder(
                      future: todoService.getCompletedTodos(),
                      builder: (context,snapshot){
                        print(snapshot.data);
                        if(snapshot.data == null){
                          return const CircularProgressIndicator();
                        }
                        else{
                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index){
                              return todoitem(
                                task: snapshot.data![index],
                              );
                            },
                          );
                        }
                      },
                    )
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddNewTask(
                        addNewTask: (newTask) => addNewTask(newTask),
                      ), )
                  );
                },
                child: const Text("Add New Task"))
          ],),
        ),
      ));
  }
}
