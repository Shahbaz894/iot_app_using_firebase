import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';



class IotScreen extends StatefulWidget {
  const IotScreen({Key? key}) : super(key: key);

  @override
  _IotScreenState createState() => _IotScreenState();
}

class _IotScreenState extends State<IotScreen> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  bool _isLEDon1 = false;
  bool _isLEDon2 = false;
  bool _isLEDon3 = false;
  bool _isLEDon4 = false;
  double _brightness = 0.0;
  double _sensorValue = 0.0;

  @override
  void initState() {
    super.initState();

    // Listen for changes to the "led_control" node for each LED and "brightness" for the slider value.
    _databaseReference.child("led_control1").onValue.listen((event) {
      final value = event.snapshot.value;
      setState(() {
        _isLEDon1 = (value == 1);
      });
    });

    _databaseReference.child("led_control2").onValue.listen((event) {
      final value = event.snapshot.value;
      setState(() {
        _isLEDon2 = (value == 1);
      });
    });

    _databaseReference.child("led_control3").onValue.listen((event) {
      final value = event.snapshot.value;
      setState(() {
        _isLEDon3 = (value == 1);
      });
    });

    _databaseReference.child("led_control4").onValue.listen((event) {
      final value = event.snapshot.value;
      setState(() {
        _isLEDon4 = (value == 1);
      });
    });

    _databaseReference.child("brightness").onValue.listen((event) {
      final value = event.snapshot.value;
      setState(() {
        _brightness = (value is double) ? value : 0.0;
      });
    });

    _databaseReference.child("sensor_value").onValue.listen((event) {
      final value = event.snapshot.value;
      setState(() {
        _sensorValue = (value is double) ? value : 0.0;
      });
    });
  }

  void _toggleLED1(bool newValue) {
    _databaseReference.child("led_control1").set(newValue ? 1 : 0);
  }

  void _toggleLED2(bool newValue) {
    _databaseReference.child("led_control2").set(newValue ? 1 : 0);
  }

  void _toggleLED3(bool newValue) {
    _databaseReference.child("led_control3").set(newValue ? 1 : 0);
  }

  void _toggleLED4(bool newValue) {
    _databaseReference.child("led_control4").set(newValue ? 1 : 0);
  }

  void _updateBrightness(double value) {
    _databaseReference.child("brightness").set(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LED Control and Sensor Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'LED 1 is ${_isLEDon1 ? 'On' : 'Off'}',
              style: TextStyle(fontSize: 20),
            ),
            Switch(
              value: _isLEDon1,
              onChanged: _toggleLED1,
            ),
            Text(
              'LED 2 is ${_isLEDon2 ? 'On' : 'Off'}',
              style: TextStyle(fontSize: 20),
            ),
            Switch(
              value: _isLEDon2,
              onChanged: _toggleLED2,
            ),
            Text(
              'LED 3 is ${_isLEDon3 ? 'On' : 'Off'}',
              style: TextStyle(fontSize: 20),
            ),
            Switch(
              value: _isLEDon3,
              onChanged: _toggleLED3,
            ),
            Text(
              'LED 4 is ${_isLEDon4 ? 'On' : 'Off'}',
              style: TextStyle(fontSize: 20),
            ),
            Switch(
              value: _isLEDon4,
              onChanged: _toggleLED4,
            ),
            SizedBox(height: 20),
            Text(
              'Sensor Value: $_sensorValue',
              style: TextStyle(fontSize: 20),
            ),
            Slider(
              value: _brightness,
              onChanged: (newValue) {
                setState(() {
                  _brightness = newValue;
                });
                _updateBrightness(newValue);
              },
              min: 0,
              max: 100,
              divisions: 100, // Added divisions to show tick marks
              label: '$_brightness', // Added a label
            ),
          ],
        ),
      ),
    );
  }
}
