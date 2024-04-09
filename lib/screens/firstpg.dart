import 'package:flutter/material.dart';
import 'package:getting_started/screens/home.dart';
// import 'package:getting_started/constants/colors.dart';

class Firstpg extends StatelessWidget {
  const Firstpg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('My To Dos'),
          // centerTitle: true,
          ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50, bottom: 20),
            child: Text(
              'My To Do App',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
              ),
              child: Text(
                "Start",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
