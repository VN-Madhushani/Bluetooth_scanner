import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ble_Scanner/controllers/bluetooth_controller.dart';
import 'package:ble_Scanner/screens/firstpg.dart';

// class BlueControlpg extends StatelessWidget {
//   BlueControlpg({Key? key}) : super(key: key);

//   final BluetoothController bluetoothController =
//       Get.find<BluetoothController>();

//   @override
//   Widget build(BuildContext context) {
//     bluetoothController.checkBluetoothState();
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text("Bluetooth Control"),
//       // ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage("images/secondpg.png"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             // Animated Bluetooth Icon
//             Obx(() {
//               return AnimatedSwitcher(
//                 duration: Duration(milliseconds: 10),
//                 transitionBuilder: (Widget child, Animation<double> animation) {
//                   return ScaleTransition(scale: animation, child: child);
//                 },
//                 child: bluetoothController.isBluetoothOn.value
//                     ? Icon(
//                         Icons.bluetooth,
//                         key: ValueKey<bool>(
//                             bluetoothController.isBluetoothOn.value),
//                         size: 250,
//                         color: Colors.blue,
//                       )
//                     : Icon(
//                         Icons.bluetooth_disabled,
//                         key: ValueKey<bool>(
//                             bluetoothController.isBluetoothOn.value),
//                         size: 250,
//                         color: Colors.red,
//                       ),
//               );
//             }),

//             //SizedBox(height: 20),
//             // Bluetooth status text
//             // Obx(() {
//             //   return AnimatedSwitcher(
//             //     duration: Duration(milliseconds: 300),
//             //     transitionBuilder: (Widget child, Animation<double> animation) {
//             //       return FadeTransition(opacity: animation, child: child);
//             //     },
//             //     child: Text(
//             //       bluetoothController.isBluetoothOn.value
//             //           ? "Bluetooth is ON"
//             //           : "Bluetooth is OFF",
//             //       key: ValueKey<bool>(bluetoothController.isBluetoothOn.value),
//             //       style: TextStyle(fontSize: 20),
//             //     ),
//             //   );
//             // }),

//             //SizedBox(height: 20),
//             // Turn on/off Bluetooth text
//             // Obx(() {
//             //   print(
//             //       "isBluetoothOn value: ${bluetoothController.isBluetoothOn.value}");
//             //   return AnimatedSwitcher(
//             //     duration: Duration(milliseconds: 300),
//             //     transitionBuilder: (Widget child, Animation<double> animation) {
//             //       return FadeTransition(opacity: animation, child: child);
//             //     },
//             //     child: Text(
//             //       bluetoothController.isBluetoothOn.value
//             //           ? ""
//             //           : "Turn on Bluetooth",
//             //       key: ValueKey<bool>(bluetoothController.isBluetoothOn.value),
//             //       style: TextStyle(fontSize: 20),
//             //     ),
//             //   );
//             // }),

//             SizedBox(height: 100),
//             Obx(() {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ElevatedButton(
//                     onPressed: bluetoothController.isBluetoothOn.value
//                         ? () {
//                             Get.to(() => Firstpg());
//                           }
//                         : null,
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: bluetoothController.isBluetoothOn.value
//                           ? Colors.blue
//                           : Colors.grey,
//                       //minimumSize: const Size(200, 55),
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                       // padding:
//                       //     EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                     ),
//                     child: const Text(
//                       "NEXT",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   if (!bluetoothController.isBluetoothOn.value)
//                     Text(
//                       'Turn Bluetooth ON',
//                       style: TextStyle(color: Colors.red, fontSize: 20),
//                     ),
//                 ],
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }

//*corerct without bg image

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ble_Scanner/controllers/bluetooth_controller.dart';
// import 'package:ble_Scanner/screens/firstpg.dart';

// class BlueControlpg extends StatelessWidget {
//   BlueControlpg({Key? key}) : super(key: key);

//   final BluetoothController bluetoothController =
//       Get.find<BluetoothController>();

//   @override
//   Widget build(BuildContext context) {
//     bluetoothController.checkBluetoothState();
//     return Scaffold(
//       body: Container(
//         // decoration: BoxDecoration(
//         //   image: DecorationImage(
//         //     image: AssetImage("images/secondpg.png"),
//         //     fit: BoxFit.cover,
//         //   ),
//         // ),

//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Animated Bluetooth Icon
//               Obx(() {
//                 return AnimatedSwitcher(
//                   duration: Duration(milliseconds: 10),
//                   transitionBuilder:
//                       (Widget child, Animation<double> animation) {
//                     return ScaleTransition(scale: animation, child: child);
//                   },
//                   child: bluetoothController.isBluetoothOn.value
//                       ? Icon(
//                           Icons.bluetooth,
//                           key: ValueKey<bool>(
//                               bluetoothController.isBluetoothOn.value),
//                           size: 250,
//                           color: Colors.blue,
//                         )
//                       : Icon(
//                           Icons.bluetooth_disabled,
//                           key: ValueKey<bool>(
//                               bluetoothController.isBluetoothOn.value),
//                           size: 250,
//                           color: Colors.red,
//                         ),
//                 );
//               }),

//               SizedBox(height: 100),
//               Obx(() {
//                 return Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     ElevatedButton(
//                       onPressed: bluetoothController.isBluetoothOn.value
//                           ? () {
//                               Get.to(() => Firstpg());
//                             }
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: bluetoothController.isBluetoothOn.value
//                             ? Colors.blue
//                             : Colors.grey,
//                         // shape: RoundedRectangleBorder(
//                         //   borderRadius: BorderRadius.all(Radius.circular(10)),
//                         // ),
//                       ),
//                       child: Text(
//                         "NEXT",
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     if (!bluetoothController.isBluetoothOn.value)
//                       Text(
//                         'Turn Bluetooth ON',
//                         style: TextStyle(color: Colors.red, fontSize: 25),
//                       ),
//                   ],
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ble_Scanner/controllers/bluetooth_controller.dart';
import 'package:ble_Scanner/screens/firstpg.dart';

class BlueControlpg extends StatelessWidget {
  BlueControlpg({Key? key}) : super(key: key);

  final BluetoothController bluetoothController =
      Get.find<BluetoothController>();

  @override
  Widget build(BuildContext context) {
    bluetoothController.checkBluetoothState();
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/secondpg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Bluetooth Icon
                Obx(() {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 10),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: bluetoothController.isBluetoothOn.value
                        ? Icon(
                            Icons.bluetooth,
                            key: ValueKey<bool>(
                                bluetoothController.isBluetoothOn.value),
                            size: 300,
                            color: Colors.blue,
                          )
                        : Icon(
                            Icons.bluetooth_disabled,
                            key: ValueKey<bool>(
                                bluetoothController.isBluetoothOn.value),
                            size: 300,
                            color: Colors.red,
                          ),
                  );
                }),

                SizedBox(height: 100),
                Obx(() {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: bluetoothController.isBluetoothOn.value
                            ? () {
                                Get.to(() => Firstpg());
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              bluetoothController.isBluetoothOn.value
                                  ? Colors.blue
                                  : Colors.grey,
                        ),
                        child: Text(
                          "NEXT",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      SizedBox(height: 10),
                      if (!bluetoothController.isBluetoothOn.value)
                        Text(
                          'Turn Bluetooth ON',
                          style: TextStyle(color: Colors.red, fontSize: 25),
                        ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
