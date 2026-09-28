import 'package:flutter/material.dart';
import 'package:securesmart/location.dart';
import 'package:securesmart/main.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:securesmart/wifilists.dart';
import 'package:securesmart/bluetooth.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(const Settings());
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
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
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _REPORT(BuildContext context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$msg.'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Code to undo the action
          },
        ),
      ),
    );
  }

  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  List<BluetoothDiscoveryResult> devicesList = [];

  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  @override
  void initState() {
    super.initState();
    _getBluetoothState();
    startScan();
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });
  }

  void startScan() {
    bluetooth.startDiscovery().listen((result) {
      setState(() {
        devicesList.add(result);
      });
    });
  }

  Future<void> _getBluetoothState() async {
    BluetoothState state = await FlutterBluetoothSerial.instance.state;
    setState(() {
      _bluetoothState = state;
    });
  }

  String myList(bluetooth) {
    List<BluetoothDiscoveryResult> devicesList = [];
    bluetooth.startDiscovery().listen((result) {
      setState(() {
        devicesList.add(result);
      });
    });

    return devicesList.toString();
  }

  String _getStatusMessage(BluetoothState state) {
    switch (state) {
      case BluetoothState.STATE_OFF:
        return 'Bluetooth is OFF';
      case BluetoothState.STATE_ON:
        return 'Bluetooth is ON';
      case BluetoothState.STATE_TURNING_OFF:
        return 'Bluetooth is turning OFF';
      case BluetoothState.STATE_TURNING_ON:
        return 'Bluetooth is turning ON';
      case BluetoothState.STATE_BLE_ON:
        return 'Bluetooth Low Energy (BLE) is ON';
      case BluetoothState.STATE_BLE_TURNING_ON:
        return 'Bluetooth Low Energy (BLE) is turning ON';
      case BluetoothState.STATE_BLE_TURNING_OFF:
        return 'Bluetooth Low Energy (BLE) is turning OFF';
      default:
        return 'Unknown Bluetooth State';
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/back.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(children: [
              header(context),
              Text(""),
              Row(
                children: [Spacer(), cont(context, 'icon6.png'), Spacer()],
              ),
              Text(""),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BluetoothDeviceScanner()),
                    );
                  },
                  child: Container(
                      width: 330,
                      height: 50, // Set the height of the container
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: Colors.white, // Set the background color
                        borderRadius: BorderRadius.circular(
                            0.0), // Set the border radius to make corners rounded
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.more_vert),
                          Text(_getStatusMessage(_bluetoothState)),
                          Spacer(),
                          Icon(Icons.hdr_strong)
                        ],
                      ))),

              Text(""),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WifiListScreen()),
                    );
                  },
                  child: row(context, "WIFI LIST ")),
              Text(""),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocationScreen()),
                  );
                },
                child: row(context, "Geo Location"),
              ),
              // Center(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       // Text(
              //       //   'Bluetooth Status:',
              //       //   style: TextStyle(fontSize: 20),
              //       // ),
              //       SizedBox(height: 10),
              //       Text(
              //         _getStatusMessage(_bluetoothState),
              //         style: TextStyle(fontSize: 18, color: Colors.blue),
              //       ),
              //       SizedBox(height: 20),
              //       ElevatedButton(
              //         onPressed: _getBluetoothState,
              //         child: Text('Refresh Status'),
              //       ),
              //     ],
              //   ),
              // ),

              // ListView.builder(
              //     itemCount: devicesList.length,
              //     itemBuilder: (context, index) {
              //       BluetoothDiscoveryResult result = devicesList[index];
              //       return Text(result.device.name ?? 'Unknown Device');
              //     }),

              // Text(
              //   myList(bluetooth),
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 12,
              //       color: Colors.white),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     _REPORT(context, myList(bluetooth));
              //   },
              //   child: Text('Refresh Status'),
              // ),
              // Container(
              //     height: 150,
              //     width: 400,
              //     padding: EdgeInsets.all(10.0),
              //     child: ListView.builder(
              //         scrollDirection: Axis
              //             .vertical, // Change scroll direction to horizontal
              //         itemCount: devicesList.length,
              //         itemBuilder: (context, index) {
              //           BluetoothDiscoveryResult result = devicesList[index];
              //           return Text(
              //             result.device.name ?? 'Unknown Device',
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 12,
              //                 color: Colors.white),
              //           );
              //         })),

              // Column(
              //   children: [
              //     ListView.builder(
              //       itemCount: devicesList.length,
              //       itemBuilder: (context, index) {
              //         BluetoothDiscoveryResult result = devicesList[index];
              //         return SizedBox(
              //             height: 200,
              //             width: 400,
              //             child: ListTile(
              //               title: Text(result.device.name ?? 'Unknown Device'),
              //               subtitle: Text(result.device.address.toString()),
              //               trailing: Text(result.rssi.toString()),
              //             ));
              //       },
              //     ),
              //     FloatingActionButton(
              //       child: Icon(Icons.search),
              //       onPressed: startScan,
              //     ),
              //   ],
              // ),

              // Text(""),
              // row(context, "TRACKER "),
              // Text(""),
              // row(context, "SECURITY "),
              Text(""),
              row(context, "POWER"),
              Text(""),
              row(context, "SWITCHES"),
              Text(""),
              row(context, "LOCKS"),
              Spacer()
            ]))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

Widget cont(context, img_) {
  return Container(
      width: 330,
      height: 150, // Set the height of the container
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.white, // Set the background color
        borderRadius: BorderRadius.circular(
            0.0), // Set the border radius to make corners rounded
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/$img_',
            fit: BoxFit.cover,
            width: 130.0,
            height: 130.0,
          ),
          Text("SETTINGS \nThe system configuration \nand auto time schedules.")
        ],
      ));
}

Widget row(context, text_) {
  return Container(
      width: 330,
      height: 50, // Set the height of the container
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.white, // Set the background color
        borderRadius: BorderRadius.circular(
            0.0), // Set the border radius to make corners rounded
      ),
      child: Row(
        children: [
          Icon(Icons.more_vert),
          Text("$text_"),
          Spacer(),
          Icon(Icons.hdr_strong)
        ],
      ));
}

Widget header(context) {
  return Row(children: [
    Text(" "),
    GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyApp()),
          );
        },
        child: Icon(Icons.home, color: Colors.white)),
    Spacer(),
    Text(
      'WELCOME HOME',
      style: TextStyle(fontSize: 13.0, color: Colors.white),
    ),
    Spacer(),
    Icon(Icons.settings, color: Colors.white),
    Text(" ")
  ]);
}
