import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
//import 'package:getting_started/controllers/bluetooth_controller.dart';
//import 'package:getting_started/Screens/home.dart';
//import 'package:getting_started/controllers/app_binding.dart';
//import 'package:getting_started/controllers/todo_controller.dart';
import 'package:getting_started/screens/auth.dart';
import 'package:getting_started/controllers/bluetooth_controller.dart';

void main() {
  Get.put(BluetoothController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    //BluetoothController bluetoothcontroller = Get.put(BluetoothController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false, //to get rid of debug at top
      title: 'BLE Scanner',
      // initialBinding: AppBinding(),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: Home(),
      home: AuthScreen(),
    );
  }
}
