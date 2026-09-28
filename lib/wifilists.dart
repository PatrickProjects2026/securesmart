import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiListScreen extends StatefulWidget {
  @override
  _WifiListScreenState createState() => _WifiListScreenState();
}

class _WifiListScreenState extends State<WifiListScreen> {
  List<WifiNetwork> _wifiNetworks = [];

  @override
  void initState() {
    super.initState();
    _loadWifiNetworks();
  }

  Future<void> _loadWifiNetworks() async {
    List<WifiNetwork> wifiNetworks;
    try {
      wifiNetworks = await WiFiForIoTPlugin.loadWifiList();
    } catch (e) {
      wifiNetworks = [];
    }

    setState(() {
      _wifiNetworks = wifiNetworks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Wi-Fi Networks'),
      ),
      body: Column(children: [
        _wifiNetworks.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _wifiNetworks.length,
                itemBuilder: (context, index) {
                  final network = _wifiNetworks[index];
                  return ListTile(
                    title: Text(network.ssid ?? "Unknown"),
                    subtitle:
                        Text("Signal Strength: ${network.level ?? 'N/A'}"),
                  );
                },
              )
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: _loadWifiNetworks,
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: WifiListScreen()));
