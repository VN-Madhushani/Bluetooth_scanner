import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getting_started/controllers/bluetooth_controller.dart';

//*************************** */

// class BlueControlpg extends StatelessWidget {
//   BlueControlpg({Key? key}) : super(key: key);

//   final BluetoothController bluetoothController =
//       Get.find<BluetoothController>();

//   @override
//   Widget build(BuildContext context) {
//     bluetoothController.checkBluetoothState();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Bluetooth Control"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Obx(() {
//               return AnimatedSwitcher(
//                 duration: Duration(milliseconds: 300),
//                 transitionBuilder: (Widget child, Animation<double> animation) {
//                   return FadeTransition(opacity: animation, child: child);
//                 },
//                 child: Text(
//                   bluetoothController.isBluetoothOn.value
//                       ? "Bluetooth is ON"
//                       : "Bluetooth is OFF",
//                   key: ValueKey<bool>(bluetoothController.isBluetoothOn.value),
//                   style: TextStyle(fontSize: 20),
//                 ),
//               );
//             }),
//             SizedBox(height: 20),
//             Obx(() {
//               print(
//                   "isBluetoothOn value: ${bluetoothController.isBluetoothOn.value}");
//               return AnimatedSwitcher(
//                 duration: Duration(milliseconds: 00),
//                 transitionBuilder: (Widget child, Animation<double> animation) {
//                   return FadeTransition(opacity: animation, child: child);
//                 },
//                 child: Text(
//                   bluetoothController.isBluetoothOn.value
//                       ? "Turn off Bluetooth"
//                       : "Turn on Bluetooth",
//                   key: ValueKey<bool>(bluetoothController.isBluetoothOn.value),
//                   style: TextStyle(fontSize: 20),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }

//*******************8 */

class BlueControlpg extends StatelessWidget {
  BlueControlpg({Key? key}) : super(key: key);

  final BluetoothController bluetoothController =
      Get.find<BluetoothController>();

  @override
  Widget build(BuildContext context) {
    bluetoothController.checkBluetoothState();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Bluetooth Control"),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Bluetooth Icon
            Obx(() {
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: bluetoothController.isBluetoothOn.value
                    ? Icon(
                        Icons.bluetooth,
                        key: ValueKey<bool>(
                            bluetoothController.isBluetoothOn.value),
                        size: 250,
                        color: Colors.blue,
                      )
                    : Icon(
                        Icons.bluetooth_disabled,
                        key: ValueKey<bool>(
                            bluetoothController.isBluetoothOn.value),
                        size: 250,
                        color: Colors.red,
                      ),
              );
            }),
            SizedBox(height: 20),
            // Bluetooth status text
            Obx(() {
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Text(
                  bluetoothController.isBluetoothOn.value
                      ? "Bluetooth is ON"
                      : "Bluetooth is OFF",
                  key: ValueKey<bool>(bluetoothController.isBluetoothOn.value),
                  style: TextStyle(fontSize: 20),
                ),
              );
            }),
            SizedBox(height: 20),
            // Turn on/off Bluetooth text
            Obx(() {
              print(
                  "isBluetoothOn value: ${bluetoothController.isBluetoothOn.value}");
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Text(
                  bluetoothController.isBluetoothOn.value
                      ? "Turn off Bluetooth"
                      : "Turn on Bluetooth",
                  key: ValueKey<bool>(bluetoothController.isBluetoothOn.value),
                  style: TextStyle(fontSize: 20),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
