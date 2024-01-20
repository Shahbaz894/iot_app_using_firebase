import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeControlButton extends StatefulWidget {
  const HomeControlButton({Key? key}) : super(key: key);

  @override
  _HomeControlButtonState createState() => _HomeControlButtonState();
}

class _HomeControlButtonState extends State<HomeControlButton> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  double _brightness = 0;
  double _sensorValue = 0.0;

  // Define variables to store pin values and LED states for each LED.
  Map<String, String> _ledPins = {
    'LED 1': '',
    'LED 2': '',
    'LED 3': '',
    'LED 4': '',
  };

  Map<String, bool> _ledStates = {
    'LED 1': false,
    'LED 2': false,
    'LED 3': false,
    'LED 4': false,
  };

  @override
  void initState() {
    super.initState();

    // Listen for changes to the "brightness" node for the slider value.
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

    // Load LED pin numbers and states from the database.
    for (String led in _ledPins.keys) {
      _databaseReference.child("$led Pin").onValue.listen((event) {
        final value = event.snapshot.value;
        setState(() {
          _ledPins[led] = (value as String?) ?? '';
        });
      });

      _databaseReference.child("$led State").onValue.listen((event) {
        final value = event.snapshot.value;
        setState(() {
          _ledStates[led] = (value == 1);
        });
      });
    }
  }

  void _updateBrightness(double value) {
    _databaseReference.child("brightness").set(value);
  }

  void _updateLedPin(String led, String value) {
    _databaseReference.child("$led Pin").set(value);
  }

  void _toggleLedState(String led, bool newState) {
    _databaseReference.child("$led State").set(newState ? 1 : 0);
    setState(() {
      _ledStates[led] = newState;
    });
  }

  // Function to show the pin input dialog.
  Future<void> _showPinInputDialog(String led, String currentPin) async {
    TextEditingController pinController = TextEditingController(text: currentPin);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Pin for $led'),
          content: TextField(
            controller: pinController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Pin Number'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newPin = pinController.text;
                _updateLedPin(led, newPin);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LED Control and Sensor Data'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Sensor Value: $_brightness',
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
              divisions: 100,
              label: 'Brightness',
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 2,
                ),
                itemCount: _ledPins.length,
                itemBuilder: (BuildContext context, int index) {
                  String led = _ledPins.keys.elementAt(index);
                  String pin = _ledPins[led] ?? '';

                  return LedCard(
                    led: led,
                    pin: pin,
                    isOn: _ledStates[led] ?? false,
                    onToggle: (newState) {
                      _toggleLedState(led, newState);
                    },
                    onUpdatePin: (newPin) {
                      _updateLedPin(led, newPin);
                    },
                    onEditPin: () {
                      _showPinInputDialog(led, _ledPins[led] ?? '');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LedCard extends StatefulWidget {
  final String led;
  final String pin;
  final bool isOn;
  final Function(bool) onToggle;
  final Function(String) onUpdatePin;
  final VoidCallback onEditPin;

  LedCard({
    required this.led,
    required this.pin,
    required this.isOn,
    required this.onToggle,
    required this.onUpdatePin,
    required this.onEditPin,
  });

  @override
  _LedCardState createState() => _LedCardState();
}

class _LedCardState extends State<LedCard> {
  bool _isEditing = false;
  TextEditingController _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pinController.text = widget.pin;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.isOn ? Colors.green : Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Show the pin input dialog when the edit button is pressed.
                  widget.onEditPin();
                },
              ),
              Text(
                '${widget.led} is ${widget.isOn ? 'On' : 'Off'}',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          if (_isEditing)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Pin Number'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onUpdatePin(_pinController.text);
                    setState(() {
                      _isEditing = false;
                    });
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          Switch(
            value: widget.isOn,
            onChanged: (newValue) {
              widget.onToggle(newValue);
            },
          ),
        ],
      ),
    );
  }
}
