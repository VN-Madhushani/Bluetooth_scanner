import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:getting_started/screens/firstpg.dart';
import 'package:getting_started/utils/utils.dart';
import 'package:getting_started/widgets/devicehome.dart';
import 'package:getting_started/models/common_data_response.dart';
import 'package:getting_started/models/common_response.dart';

class BluetoothController extends GetxController {
  //FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  FlutterBluePlus flutterBlue = FlutterBluePlus();

  //isScanning is a  reactive variable,boolean false is converted to an observable
  RxBool isScanning = false.obs;
  RxBool isBluetoothOn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkBluetoothState();

    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      if (state == BluetoothAdapterState.on) {
        isBluetoothOn.value = true;
        Get.to(() => Firstpg());
      } else {
        isBluetoothOn.value = false;
      }
    });
  }

  Future<void> checkBluetoothState() async {
    try {
      if (await FlutterBluePlus.isSupported == false) {
        print("Bluetooth not supported by this device");
        return;
      }

      var subscription =
          FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
        print(state);
        if (state == BluetoothAdapterState.on) {
          // usually start scanning, connecting, etc
          //Get.to(() => Firstpg());
        } else {
          // show an error to the user, etc
          print("Bluetooth is not on");
        }
      });

      bool isOn = await FlutterBluePlus.isOn;
      isBluetoothOn.value = isOn;

      print("BLE status:**********");
      print(isOn);
      subscription.cancel();
    } catch (e) {
      print("Error checking ble state:$e");
    }
  }

  // Future<void> turnOnBluetooth() async {
  //   try {
  //     // Note: Turning Bluetooth on/off might require platform-specific code.
  //     //await flutterBlue.turnOn();
  //     isBluetoothOn.value = true;
  //     print('Bluetooth turned on');
  //     Get.to(() => Firstpg());
  //   } catch (e) {
  //     print('Error turning on Bluetooth: $e');
  //   }
  // }

  // Future<void> turnOffBluetooth() async {
  //   try {
  //     // Note: Turning Bluetooth on/off might require platform-specific code.
  //     isBluetoothOn.value = false;
  //     print('Bluetooth turned off');
  //   } catch (e) {
  //     print('Error turning off Bluetooth: $e');
  //   }
  // }

  // Future<void> checkBluetoothState() async {
  //   bool isOn = await FlutterBluePlus.isOn;
  //   isBluetoothOn.value = isOn;
  // }

  // void turnOnBluetooth() {
  //   isBluetoothOn.value = true;
  // }

  // void turnOffBluetooth() {
  //   isBluetoothOn.value = false;
  // }

  // Future<void> turnOn({int timeout = 60}) async {
  //   try {
  //     await flutterBlue.turnOn(); // This might need platform-specific code to actually work
  //     isBluetoothOn.value = true;
  //   } catch (e) {
  //     print('Error turning on Bluetooth: $e');
  //   }
  // }

  // Future<void> turnOffBluetooth() async {
  //   try {
  //     await flutterBlue.turnOff(); // This might need platform-specific code to actually work
  //     isBluetoothOn.value = false;
  //   } catch (e) {
  //     print('Error turning off Bluetooth: $e');
  //   }
  // }

  Future scanDevices() async {
    print(isScanning.value);

    if (isScanning.value) {
      return;
    }

    bool a = await FlutterBluePlus.isOn;
    print(a);

    isScanning.value = true;
    print("Start scanning");
    //start scan for 5 sec

    var subscription = FlutterBluePlus.onScanResults.listen(
      (results) {
        if (results.isNotEmpty) {
          ScanResult r = results.last; // the most recently found device
          print(
              '${r.device.remoteId}: "${r.advertisementData.advName}" found!');
        }
      },
      onError: (e) => print(e),
    );

    print("Start scannning 2");

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
    //await FlutterBluePlus.stopScan();
    // FlutterBluePlus.stopScan();
    isScanning.value = false;
    print("Stop scanning");
    subscription.cancel();
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      // Listen for connection state changes
      var subscription =
          device.connectionState.listen((BluetoothConnectionState state) async {
        if (state == BluetoothConnectionState.disconnected) {
          // Handle disconnection
          //print("${device.disconnectReasonCode} ${device.disconnectReasonDescription}");
          print("disconnection occur");
        }
      });

      // Cleanup: cancel subscription when disconnected
      device.cancelWhenDisconnected(subscription, delayed: true, next: true);

      // Connect to the device
      await device.connect();
      print('Connected to the device');

      // Disconnect from the device when done
      //await device.disconnect();
      //print('Disconnected from the device');

      Get.to(() => DeviceHomePage(device: device));

      subscription.cancel();
    } catch (e) {
      print('Error connecting to the device: $e');
    }
  }

  Future<CommonDataResponse> readUserDetails(BluetoothDevice device) async {
    CommonResponse commonResponse = await readUserDetailsRequest(device);
    if (commonResponse.state == "S100") {
      await Future.delayed(Duration(seconds: 3));
      CommonDataResponse commonDataResponse =
          await readUserDetailsResponse(device);
      print(commonDataResponse.toJson());
      print("response**************");
      print(commonDataResponse);
      // {state: S100, stateDescription: Success, data: 26x2R1,'SSID1', 'pwd1'}
      return commonDataResponse;
    } else {
      return CommonDataResponse.fromDetails(
        commonResponse.state,
        commonResponse.stateDescription,
      );
    }
  }

  Future<bool> write(BluetoothDevice device, List<int> data, String ServiceUUID,
      String charUUID) async {
    bool response = false;
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (var service in services) {
        if (service.uuid.toString() == ServiceUUID) {
          for (var element in service.characteristics) {
            if (element.uuid.toString() == charUUID) {
              await element
                  .write(
                    data,
                  )
                  .then((value) => response = true)
                  .onError((error, stackTrace) {
                response = false;
                return response;
              });
              print("done");
            }
          }
        }
      }
    } catch (e) {
      return response;
    }
    return response;
  }

  Future<String?> read(
      BluetoothDevice device, String ServiceUUID, String charUUID) async {
    String? response = null;
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (var service in services) {
        if (service.uuid.toString() == ServiceUUID) {
          for (var element in service.characteristics) {
            if (element.uuid.toString() == charUUID) {
              List<int> value = await element.read();
              print(value);
              String? valueString = Utils.resultToSting(value);
              response = valueString;
              if (valueString!.isEmpty) {
                return null;
              }
            }
          }
        }
      }
    } catch (e) {
      return response;
    }
    return response;
  }

  Future<CommonResponse> readUserDetailsRequest(BluetoothDevice device) async {
    bool response = await write(
      device,
      Utils.convertStringToByte("10"),
      "1001",
      "f0001002-0451-4000-b000-000000000000",
    );

    if (response) {
      return CommonResponse.fromDetails(
        "S100",
        "Success",
      );
    } else {
      return CommonResponse.fromDetails(
        "E100",
        "Read user details request failed",
      );
    }
  }

  Future<CommonDataResponse> readUserDetailsResponse(
      BluetoothDevice device) async {
    String? stringResponse = await read(
      device,
      "1001",
      "f0001003-0451-4000-b000-000000000000",
    );
    //26x2R1,'SSID1', 'pwd1'

    if (stringResponse == null) {
      return CommonDataResponse.fromDetails(
        "E100",
        "Did't receive user details",
      );
    } else {
      // convert string response to model
      return CommonDataResponse.fromDetails(
        "S100",
        "Success",
        data: stringResponse,
      );
    }
  }

  Future<CommonResponse> writeUserDetails(
    BluetoothDevice device,
    String data,
  ) async {
    bool response = await write(
      device,
      Utils.convertStringToByte(data),
      "1001",
      "f0001004-0451-4000-b000-000000000000",
    );

    if (response) {
      return CommonResponse.fromDetails(
        "S100",
        "Success",
      );
    } else {
      return CommonResponse.fromDetails(
        "E100",
        "Failed to write user details",
      );
    }
  }
}
