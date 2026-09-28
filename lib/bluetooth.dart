import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceScanner extends StatefulWidget {
  @override
  _BluetoothDeviceScannerState createState() => _BluetoothDeviceScannerState();
}

class _BluetoothDeviceScannerState extends State<BluetoothDeviceScanner> {
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  List<BluetoothDiscoveryResult> devicesList = [];

  @override
  void initState() {
    super.initState();
    startScan();
  }

  void startScan() {
    bluetooth.startDiscovery().listen((result) {
      setState(() {
        devicesList.add(result);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Device Scanner'),
      ),
      body: devicesList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: devicesList.length,
              itemBuilder: (context, index) {
                BluetoothDiscoveryResult result = devicesList[index];
                return ListTile(
                  title: Text(result.device.name ?? 'Unknown Device'),
                  subtitle: Text(result.device.address.toString()),
                  trailing: Text(result.rssi.toString()),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: startScan,
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: BluetoothDeviceScanner()));
