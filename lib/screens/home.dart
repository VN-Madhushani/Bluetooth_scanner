import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getting_started/constants/colors.dart';
import 'package:getting_started/models/todo.dart';
import 'package:getting_started/widgets/todo_item.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key:key);

  final todoList = ToDo.todoList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50,bottom: 20),
                        child: Text(
                          'All To Dos',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (ToDo todoo in todoList)
                        ToDoItem(todo:todoo,),


                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   boxShadow: const BoxShadow(
                  //     color: Colors.grey,
                  //     offset: Offset(0.0,0.0),
                  //     blurRadius: 10.0,
                  //     spreadRadius: 0.0,
                  //   ),
                  // ),
                ),
              ),
            ],),
          )
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding:EdgeInsets.symmetric(horizontal: 15) ,
      decoration: BoxDecoration(
          color: Colors.white,borderRadius:BorderRadius.circular(20)
      ),
      child:TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            maxWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: AssetImage("images/face.jpg"),
              ),
            ),
          ),
        ],
      ),
      // centerTitle: true,
    );
  }
}
