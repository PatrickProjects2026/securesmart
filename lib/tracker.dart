import 'package:flutter/material.dart';
import 'package:securesmart/main.dart';

void main() {
  runApp(const Tracker());
}

String currentStatus = "System Status";

class Tracker extends StatelessWidget {
  const Tracker({super.key});

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _showBottomSheet(BuildContext context, msg) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('$msg'),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                ),
              ],
            ),
          );
        });
  }

  void _showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('This is a snackbar.'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Code to undo the action
          },
        ),
      ),
    );
  }

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
              header(context, _REPORT),
              Text(""),
              Row(
                children: [Spacer(), cont(context, 'icon1.png'), Spacer()],
              ),
              GestureDetector(
                  onTap: () {
                    // _REPORT(context, '$currentStatus is Active.');
                    setState(() {
                      currentStatus += " Changed";
                    });
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
                          Text("$currentStatus"),
                          Spacer(),
                          Icon(Icons.hdr_strong)
                        ],
                      ))),
              Text(""),
              row(context, "TOM LOCATION", _REPORT, setState),
              Text(""),
              row(context, "JIM LOCATION", _REPORT, setState),
              Text(""),
              row(context, "PHONE2", _REPORT, setState),
              Text(""),
              row(context, "PET 002", _REPORT, setState),
              Text(""),
              row(context, "PET 003", _REPORT, setState),
              Text(""),
              row(context, "PET 004", _REPORT, setState),
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
          Text(
              "TRACKER \nTrackers for Pets, Devices,\nand Keys Features: Locate and \nfind your valuables with ease!")
        ],
      ));
}

Widget row(context, text_, _REPORT, setState) {
  int no = 0;
  return GestureDetector(
      onTap: () {
        _REPORT(context, '$text_ is Active.');
        setState(() {
          no++;
          currentStatus = "$no";
        });
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
              Text("$text_"),
              Spacer(),
              Icon(Icons.hdr_strong)
            ],
          )));
}

Widget header(context, _REPORT) {
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
    GestureDetector(
        onTap: () => {_REPORT(context, 'SYSTEM IS RUNNING')},
        child: Icon(Icons.settings, color: Colors.white)),
    Text(" ")
  ]);
}



// wifi, gps , bluetooth 

// Tracker   [GPS]          [gbs]
// Cameras   [CCTV]         [wifi] 
// Switches  [Appliances]   [wifi]
// Locks     [Gates]        [wifi] 

// ARDUINO AND FLUTTER 
// * Flutter can serve as the front-end user interface and 
//   Arduino handles the hardware interactions. 

// 1.Arduino Setup:
// The Arduino code reads an analog sensor value and prints it to the serial monitor.

// 2.Flutter Setup:
// The Flutter app uses the flutter_bluetooth_serial package to manage Bluetooth communication.
// The app scans for paired Bluetooth devices and connects to the one matching your Arduino’s Bluetooth name.
// Once connected, the app listens for incoming data from the Arduino and displays it on the screen.

// Bluetooth State: The app monitors the Bluetooth state to inform the user about whether Bluetooth is enabled or not.
// Paired Devices: The app retrieves and displays a list of paired Bluetooth devices.
// Connecting to a Device: The user can select a device from the list and connect to it.
// Receiving Data: Once connected, the app listens for incoming data and displays it.


//Classic Bluetooth: 10 meters (30 feet) up to 100 meters (330 feet) 
//Classic Bluetooth: Data rates up to 3 Mbps (Bluetooth 2.0+EDR).

//Wi-Fi (2.4 GHz): 30 to 45 meters (100 to 150 feet) up to 90 meters (300 feet) outdoors.
//Wi-Fi (802.11n): r72 Mbps (basic rates) to several hundred Mbps (with MIMO and channel bonding).




//bluetooth,wifi,gps [gps,wifi]

// Get Current Location
// Watch Location Changes
// Calculate Distance Between Two Points
// Get Address from Coordinates
//
//