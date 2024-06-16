import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:getting_started/controllers/bluetooth_controller.dart';
//import 'package:getting_started/controllers/todo_controller.dart';
//import 'package:getting_started/models/todo.dart';
//import 'package:getting_started/screens/home.dart';
//import 'package:table_calendar/table_calendar.dart';
// import 'package:getting_started/constants/colors.dart';

class Firstpg extends StatelessWidget {
  Firstpg({Key? key}) : super(key: key);

  //ToDOController controller = Get.find();
  //final ToDOController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BLE SCANNER"),
        ),
        body: GetBuilder<BluetoothController>(
            init: BluetoothController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Color.fromARGB(255, 137, 109, 230),
                      child: const Center(
                        child: Text(
                          "Bluetooth Scanner",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        //onPressed: () {},
                        //onPressed: () => controller.scanDevices(),
                        onPressed: () async {
                          controller.scanDevices();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(350, 55),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                        child: const Text(
                          "Scan",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    StreamBuilder<List<ScanResult>>(
                        stream: controller.scanResults,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final data = snapshot.data![index];
                                  return Card(
                                    elevation: 2,
                                    child: ListTile(
                                      // ignore: deprecated_member_use
                                      title: Text(data.device.name),
                                      // ignore: deprecated_member_use
                                      subtitle: Text(data.device.id.id),
                                      trailing: Text(data.rssi.toString()),
                                    ),
                                  );
                                });
                          } else {
                            return const Center(
                              child: Text("No devices found"),
                            );
                          }
                        })
                  ],
                ),
              );
            }));
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //         // title: Text('My To Dos'),
  //         // centerTitle: true,
  //         ),
  //     body: Column(
  //       children: [
  //         Obx(
  //           () => Column(
  //             children:
  //                 controller.toDOs.value.map((todo) => Text(todo)).toList(),
  //           ),
  //         ),
  //         // Text(controller.toDOs.value[1]),
  //         Obx(
  //           () => Text(controller.singletoDO.value),
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(top: 50, bottom: 20),
  //           child: Text(
  //             'BLE Scan',
  //             style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
  //           ),
  //         ),
  //         Center(
  //           child: ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               padding: EdgeInsets.all(20),
  //             ),
  //             child: Text(
  //               "Scan",
  //               style: TextStyle(
  //                 fontSize: 30,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //             onPressed: () {
  //               controller.Change_todo('Jy');
  //               // Navigator.push(
  //               //     context, MaterialPageRoute(builder: (context) => Home()));
  //             },
  //             // onPressed = () =>Get.to (())
  //           ),
  //         ),

  //         Container(
  //           alignment: Alignment.bottomRight,
  //           child: ElevatedButton(
  //             child: Text(
  //               '>>',
  //               style: TextStyle(
  //                 fontSize: 40,
  //               ),
  //             ),
  //             onPressed: () => Get.to(() => Home()),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  //void _onDaySelected(BuildContext context, DateTime selectedDay) async {
  //   TextEditingController eventController = TextEditingController();
  //   String? eventName = await showDialog<String>(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Add Event'),
  //         content: TextField(
  //           controller: eventController,
  //           decoration: InputDecoration(
  //             hintText: 'Enter event name',
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context, null);
  //             },
  //             child: Text('Cancel'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.pop(context, eventController.text);
  //             },
  //             child: Text('Add'),
  //           ),
  //         ],
  //       );
  //     },
  //   );

  //   if (eventName != null && eventName.isNotEmpty) {
  //     controller.addTask(selectedDay, eventName);
  //   }
  // }

