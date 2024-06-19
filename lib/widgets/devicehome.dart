// import 'package:flutter/material.dart';
// //import 'package:flutter/widgets.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:getting_started/controllers/bluetooth_controller.dart';

// class DeviceHomePage extends StatelessWidget {
//   final BluetoothDevice device;
//   final String? valuereturn;

//   const DeviceHomePage({
//     Key? key,
//     required this.device,
//     this.valuereturn,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(device.name.isNotEmpty ? device.name : 'Unknown Device'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//                 'Connected to ${device.name.isNotEmpty ? device.name : 'Unknown Device'}'),
//             //Text('SSIDPWD:${valuereturn ?? 'NA'}'),
//           ],
//         ),
//         // child: Text(
//         //     'Connected to ${device.name.isNotEmpty ? device.name : 'Unknown Device'}'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:getting_started/controllers/bluetooth_controller.dart';
import 'package:getting_started/models/common_data_response.dart';
import 'package:getting_started/models/common_response.dart';
import 'dart:async';
import 'package:getting_started/utils/utils.dart';

class DeviceHomePage extends StatefulWidget {
  final BluetoothDevice device;

  const DeviceHomePage({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  _DeviceHomePageState createState() => _DeviceHomePageState();
}

class _DeviceHomePageState extends State<DeviceHomePage> {
  String ssid = '';
  String password = '';
  String status = 'Disconnected'; // Default status

  final TextEditingController ssidController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _readUserDetails();
  }

  Future<void> _readUserDetails() async {
    BluetoothController bluetoothController = Get.find();
    CommonDataResponse commonDataResponse =
        await bluetoothController.readUserDetails(widget.device);

    if (commonDataResponse.state == "S100") {
      String data = commonDataResponse.data;
      List<String> dataList = data.split(':');
      setState(() {
        ssid = dataList[0];
        password = dataList[1];
      });
    } else {
      print(commonDataResponse.stateDescription);
    }
  }

  Future<void> _writeUserDetails() async {
    // if (widget.device.state != BluetoothDeviceState.connected) {
    //   print('Device is not connected');
    //   return;
    // }
    String newssid = ssidController.text;
    String newPassword = passwordController.text;
    String combinedData = '$newssid:$newPassword';

    print(combinedData);
    print(Utils.convertStringToByte(combinedData));

    BluetoothController bluetoothController = Get.find();
    CommonResponse commonResponse =
        await bluetoothController.writeUserDetails(widget.device, combinedData);
    //print(commonResponse);

    if (commonResponse.state == 'S100') {
      print("Write success");
      _readUserDetails();
      _showSuccessSnackbar(context);
    } else {
      print('write failed:${commonResponse.stateDescription}');
    }
  }

  void _showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Write operation was successful.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to write user details: $errorMessage'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name.isNotEmpty
            ? widget.device.name
            : 'Unknown Device'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Device Information',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Device name: ${widget.device.name}'),
            Text('SSID: $ssid'),
            Text('Password: $password'),
            Text('Status: $status'),
            //SizedBox(height: 16),

            // ElevatedButton(
            //   onPressed: _readUserDetails,
            //   child: const Text('Read Details'),
            // ),

            TextField(
              controller: ssidController,
              decoration: InputDecoration(
                labelText: 'New SSID',
              ),
            ),

            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _writeUserDetails,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
