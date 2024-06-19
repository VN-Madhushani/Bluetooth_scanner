import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:getting_started/constants/button.dart';

class DeviceListItem extends StatelessWidget {
  final ScanResult device;
  final Function(ScanResult) onSettingsPressed;
  final Function(BluetoothDevice) onConnectPressed;

  const DeviceListItem({
    Key? key,
    required this.device,
    required this.onSettingsPressed,
    required this.onConnectPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceName =
        device.device.name.isNotEmpty ? device.device.name : 'Unknown Device';

    return Card(
      elevation: 2,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => onSettingsPressed(device),
        ),
        title: Text(deviceName),
        // subtitle: Text(device.device.id.id),
        // trailing: Text(device.rssi.toString()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(device.device.id.id),
            Text(device.rssi.toString()),
          ],
        ),
        trailing: SizedBox(
          width: 80,
          child: Button(
            label: 'Connect',
            press: () => onConnectPressed(device.device),
          ),
        ),
      ),
    );
  }
}
