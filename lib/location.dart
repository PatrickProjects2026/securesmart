import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Position? _currentPosition;
  String _locationMessage = "Current Location";

  String _address = "Fetching address..."; // Default text

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _address = '${place.street}, ${place.locality}, ${place.country}';
        });
      }
    } catch (e) {
      setState(() {
        _address = 'Failed to fetch address';
      });
      print('Error: $e');
    }
  }

  double lat = 0;
  double lon = 0;

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled
        return;
      }

      // Check for location permissions
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          // Handle permission denied
          return;
        }
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _locationMessage =
            "Lat: ${position.latitude}, Long: ${position.longitude}";
        lat = position.latitude;
        lon = position.longitude;
      });
    } catch (e) {
      setState(() {
        _locationMessage = "Failed to get location: $e";
      });
    }

    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      setState(() {
        _address = '${place.street}, ${place.locality}, ${place.country}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Location'),
      ),
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/back.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(children: [
            Text(""),
            Center(
              child: _currentPosition == null
                  ? CircularProgressIndicator()
                  : Text(
                      _locationMessage,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
            ),
            Text(
              _address,
              style: TextStyle(fontSize: 18, color: Colors.white),
            )
          ])),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.my_location), onPressed: _getCurrentLocation),
    );
  }
}

void main() => runApp(MaterialApp(home: LocationScreen()));
