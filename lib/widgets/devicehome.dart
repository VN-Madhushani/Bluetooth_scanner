// import 'package:flutter/material.dart';
// //import 'package:flutter/widgets.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:ble_Scanner/controllers/bluetooth_controller.dart';

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

/*
import 'package:ble_Scanner/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:ble_Scanner/controllers/bluetooth_controller.dart';
import 'package:ble_Scanner/models/common_data_response.dart';
import 'package:ble_Scanner/models/common_response.dart';
import 'dart:async';
import 'package:ble_Scanner/utils/utils.dart';

class DeviceHomePage extends StatefulWidget {
  final BluetoothDevice device;
  final BluetoothController bluetoothController =
      BluetoothController(); // Instantiate BluetoothController

  DeviceHomePage({
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

  @override
  void dispose() {
    ssidController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _readUserDetails() async {
    BluetoothController bluetoothController = Get.find();
    CommonDataResponse commonDataResponse =
        await bluetoothController.readUserDetails(widget.device);

    if (mounted) {
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

    if (mounted) {
      if (commonResponse.state == 'S100') {
        print("Write success");
        _readUserDetails();
        _showSuccessSnackbar(context);
      } else {
        print('write failed:${commonResponse.stateDescription}');
      }
    }
  }

  void _showSuccessSnackbar(BuildContext context) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Changes saved successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showErrorSnackbar(BuildContext context, String errorMessage) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Changes failed to save.: $errorMessage'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.device.name.isNotEmpty
                      ? widget.device.name
                      : 'Unknown Device',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.bluetoothController.disconnectDevice(widget.device);
                  },
                  child: Text(
                    "Disconnect",
                    style: TextStyle(fontSize: 25),
                  ),
                  //style: ButtonStyle(backgroundColor:Color),
                  style: ElevatedButton.styleFrom(
                    //primary: Colors.white, // Background color
                    //onPrimary: Colors.black, // Text color
                    side: BorderSide(
                        color: Colors.black,
                        width: 2), // Border color and width
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Rounded corners (optional)
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/devicehome.png'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Device Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Device name: ${widget.device.name}',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text('SSID: $ssid',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Text('Password: $password',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Text('Status: $status',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  SizedBox(height: 25),
                  // Add other fields like SSID, Password, Status here
                  SizedBox(height: 16),
                  TextField(
                    controller: ssidController,
                    decoration: InputDecoration(
                      labelText: 'New SSID ?',
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
                  // ElevatedButton(
                  //   onPressed: () {
                  //     widget.bluetoothController
                  //         .disconnectDevice(widget.device);
                  //   },
                  //   child: Text("Disconnect"),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

*/

import 'package:ble_Scanner/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:ble_Scanner/controllers/bluetooth_controller.dart';
import 'package:ble_Scanner/models/common_data_response.dart';
import 'package:ble_Scanner/models/common_response.dart';
import 'dart:async';
import 'package:ble_Scanner/utils/utils.dart';

class DeviceHomePage extends StatefulWidget {
  final BluetoothDevice device;
  final BluetoothController bluetoothController =
      BluetoothController(); // Instantiate BluetoothController

  DeviceHomePage({
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

  bool _showSettings =
      false; // Control the visibility of SSID and password input fields

  @override
  void initState() {
    super.initState();
    _readUserDetails();
  }

  @override
  void dispose() {
    ssidController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _readUserDetails() async {
    BluetoothController bluetoothController = Get.find();
    CommonDataResponse commonDataResponse =
        await bluetoothController.readUserDetails(widget.device);

    if (mounted) {
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
  }

  Future<void> _writeUserDetails() async {
    String newssid = ssidController.text;
    String newPassword = passwordController.text;
    String combinedData = '$newssid:$newPassword';

    print(combinedData);
    print(Utils.convertStringToByte(combinedData));

    BluetoothController bluetoothController = Get.find();
    CommonResponse commonResponse =
        await bluetoothController.writeUserDetails(widget.device, combinedData);

    if (mounted) {
      if (commonResponse.state == 'S100') {
        print("Write success");
        _readUserDetails();
        _showSuccessSnackbar(context);
      } else {
        print('write failed:${commonResponse.stateDescription}');
      }
    }
  }

  void _showSuccessSnackbar(BuildContext context) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Changes saved successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showErrorSnackbar(BuildContext context, String errorMessage) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Changes failed to save.: $errorMessage'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _toggleSettings() {
    setState(() {
      _showSettings = !_showSettings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.device.name.isNotEmpty
                  ? widget.device.name
                  : 'Unknown Device',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/devicehome.png'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Device Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Device name: ${widget.device.name}',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text('SSID: $ssid',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Text('Password: $password',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Text('Status: $status',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon:
                            Icon(Icons.settings, size: 30, color: Colors.white),
                        onPressed: _toggleSettings,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          widget.bluetoothController
                              .disconnectDevice(widget.device);
                        },
                        child: Text(
                          "Disconnect",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                  if (_showSettings) ...[
                    SizedBox(height: 16),
                    TextField(
                      controller: ssidController,
                      style: TextStyle(backgroundColor: Colors.white),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
