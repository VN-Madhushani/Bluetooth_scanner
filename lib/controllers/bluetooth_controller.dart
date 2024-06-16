import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  //FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  FlutterBluePlus flutterBlue = FlutterBluePlus();

  //isScanning is a  reactive variable,boolean false is converted to an observable
  RxBool isScanning = false.obs;

  // Future scanDevices() async{
  //   if(await Permission.bluetoothScan.request().isGranted){
  //     if(await Permission.bluetoothConnect.request().isGranted){
  //       ble.startScan(timeout: Duration(seconds: 15));
  //       ble.stopScan();
  //     }
  //   }
  // }

  Future scanDevices() async {
    // if (await Permission.bluetoothScan.request().isGranted){
    //   if(await Permission.bluetoothConnect.request().isGranted){

    //   }
    // }
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

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));

    // FlutterBluePlus.stopScan();
    isScanning.value = false;
    print("Stop scanning");
  }

//    Future<void> connectToDevice(BluetoothDevice device)async {
//     await device?.connect(timeout: Duration(seconds: 15));
//     device?.state.listen((isConnected) {
//       if(isConnected == BluetoothDeviceState.connecting){
//         print("Device connecting to: ${device.name}");
//       }else if(isConnected == BluetoothDeviceState.connected){
//         print("Device connected: ${device.name}");
//       }else{
//         print("Device Disconnected");
//       }
//     });
//  }

  //showing all available devices

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
}
