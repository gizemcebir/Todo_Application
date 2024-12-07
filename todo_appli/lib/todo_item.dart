import "package:flutter/material.dart";
import "package:todo_appli/constants/tast_type.dart";
import "package:todo_appli/model/todo.dart";

import "model/task.dart";

class todoitem extends StatefulWidget {
  const todoitem({super.key, required this.task});
  final Todo task;

  @override
  State<todoitem> createState() => _todoitemState();
}

class _todoitemState extends State<todoitem> {
  bool isChecked = false ;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.completed! ? Colors.grey : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /*widget.task.type == TaskType.note
                 ? const Icon(Icons.text_snippet)
                 : widget.task.type == TaskType.contest
                    ? const Icon(Icons.emoji_events)
                    : const Icon(Icons.newspaper),*/
            Expanded(
              child: Column(
                children: [
                  Text(
                    widget.task.todo!,
                    style: TextStyle(
                      decoration: widget.task.completed!
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 21),
                  ),
              Text("User:${widget.task.userId!}"),
                ],
              ),
            ),
            Checkbox(
                value: isChecked,
                onChanged: (val) => {
              setState(
                  () {
                    widget.task.completed = !widget.task.completed!;
                    isChecked = val!;
                  },
              )
            },
            )
          ],
        ),
      ) ,
    );
  }
}
