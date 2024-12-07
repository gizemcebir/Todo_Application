import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_appli/constants/color.dart';
import 'package:todo_appli/constants/tast_type.dart';
import 'package:todo_appli/model/todo.dart';
import 'package:todo_appli/service/todo_service.dart';
import 'model/task.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key, required this.addNewTask});

  final void Function(Task newTask) addNewTask;

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {

  TextEditingController titleController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TodoService todoService = TodoService();

  TaskType taskType = TaskType.note;


  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height ;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child:  Scaffold(
        backgroundColor: HexColor(backgroundColor),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: deviceWidth,
                height: deviceHeight/10,
                color: Colors.purple,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        } ,
                        icon: const Icon(
                          Icons.close,
                          size: 40,
                          color: Colors.white,
                        ),
                    ),
                    const Expanded(child: Text("Add New Tasks",
                      style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                      textAlign: TextAlign.center,
                    ))
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10),
                  child: Text("Task Title")),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Kategori"),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 300),
                              content: Text("kategori seçildi")
                          ),
                        );
                        setState(() {
                          taskType = TaskType.calendar;
                        });
                      },
                      child: const Icon(
                        Icons.text_snippet
                      )
                    ),
                    GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  duration: Duration(milliseconds: 300),
                                  content: Text("kategori seçildi"))
                          );
                        },
                        child: const Icon(
                            Icons.newspaper
                        )
                    ),
                    GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  duration: Duration(milliseconds: 300),
                                  content: Text("kategori seçildi")
                              ),
                          );
                          setState(() {
                            taskType = TaskType.contest;
                          });
                        },
                        child: const Icon(
                            Icons.emoji_events
                        )
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text("User ID:"),
                          Padding(padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                              child: TextField(
                                controller: userIdController,
                                decoration: const InputDecoration(
                                    filled: true,
                                  fillColor: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("Time"),
                          Padding(padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                              child: TextField(
                                controller: timeController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                  child: Text("Description"),
              ),
              SizedBox(
                height: 300,
                child: TextField(
                  controller: descriptionController,
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                  ),
                ),
              ),

              ElevatedButton(
                  onPressed: () {
                    Task newTask = Task(title: titleController.text,
                        description: descriptionController.text,
                        isCompleted: false,
                        type: taskType);
                    widget.addNewTask(newTask);
                    saveTodo();
                    Navigator.pop(context);
                  },
                  child: const Text("Save "),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveTodo(){
    Todo newTodo = Todo(
        id: -1,
        todo: titleController.text,
        completed: false,
        userId: int.parse(userIdController.text),
    );

    todoService.addTodo(newTodo);
  }
}
