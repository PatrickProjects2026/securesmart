import 'package:flutter/material.dart';
import 'package:securesmart/locks.dart';
import 'package:securesmart/main.dart';
import 'package:securesmart/power.dart';
import 'package:securesmart/security.dart';
import 'package:securesmart/settings.dart';
import 'package:securesmart/switches.dart';
import 'package:securesmart/tracker.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

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
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  cont1(context, 'icon1.png'),
                  Text(" "),
                  cont2(context, 'icon2.png'),
                  Spacer()
                ],
              ),
              Text(""),
              Row(
                children: [
                  Spacer(),
                  cont3(context, 'icon3.png'),
                  Text(" "),
                  cont4(context, 'icon4.png'),
                  Spacer()
                ],
              ),
              Text(""),
              Row(
                children: [
                  Spacer(),
                  cont5(context, 'icon5.png'),
                  Text(" "),
                  cont6(context, 'icon6.png'),
                  Spacer()
                ],
              ),
              Spacer()
            ]))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

Widget cont1(context, img_) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Tracker()),
        );
      },
      child: Container(
        child: Image.asset(
          'assets/$img_',
          fit: BoxFit.cover,
          width: 150.0,
          height: 150.0,
        ),
      ));
}

Widget cont2(context, img_) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Security()),
        );
      },
      child: Container(
        child: Image.asset(
          'assets/$img_',
          fit: BoxFit.cover,
          width: 150.0,
          height: 150.0,
        ),
      ));
}

Widget cont3(context, img_) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Power()),
        );
      },
      child: Container(
        child: Image.asset(
          'assets/$img_',
          fit: BoxFit.cover,
          width: 150.0,
          height: 150.0,
        ),
      ));
}

Widget cont4(context, img_) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Switches()),
        );
      },
      child: Container(
        child: Image.asset(
          'assets/$img_',
          fit: BoxFit.cover,
          width: 150.0,
          height: 150.0,
        ),
      ));
}

Widget cont5(context, img_) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Locks()),
        );
      },
      child: Container(
        child: Image.asset(
          'assets/$img_',
          fit: BoxFit.cover,
          width: 150.0,
          height: 150.0,
        ),
      ));
}

Widget cont6(context, img_) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Settings()),
        );
      },
      child: Container(
        child: Image.asset(
          'assets/$img_',
          fit: BoxFit.cover,
          width: 150.0,
          height: 150.0,
        ),
      ));
}

Widget cont(context, img_) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      },
      child: Container(
        child: Image.asset(
          'assets/$img_',
          fit: BoxFit.cover,
          width: 150.0,
          height: 150.0,
        ),
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
