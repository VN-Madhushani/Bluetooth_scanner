import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ble_Scanner/constants/colors.dart';
import 'package:ble_Scanner/screens/detailspg.dart';

import '../models/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  final onLongPress;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          //print("Clicked on the Todo Item.");
          onToDoChanged(todo);
        },
        onLongPress: () {
          //navigate to details page
          print("Long Press");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Detailspg(todo: todo),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isdone
              ? Icons.check_box
              : Icons
                  .check_box_outline_blank, //if it is done mark checkbox othwse keep empty
          color: tdBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: todo.isdone ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              //print("Clicked on delete icon.");
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
