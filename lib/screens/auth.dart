import 'package:getting_started/constants/button.dart';
import 'package:getting_started/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:getting_started/screens/firstpg.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Testing gigs",
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
              Text(
                "Connect with the devices",
                style: TextStyle(color: Colors.grey),
              ),
              Expanded(
                child: Image(
                  image: AssetImage("images/wavetec.png"),
                ),
              ),
              Button(
                  label: "START",
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Firstpg()));
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
