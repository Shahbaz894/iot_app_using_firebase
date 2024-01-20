import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class AppDataProvider extends ChangeNotifier {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  double _brightness = 0.0;
  double _sensorValue = 0.0;

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

  Map<String, String> _ledButtonTitles = {
    'LED 1': 'Button 1', // Initialize with default button titles
    'LED 2': 'Button 2',
    'LED 3': 'Button 3',
    'LED 4': 'Button 4',
  };

  // Constructor
  AppDataProvider() {
    // Listen for changes to the "brightness" node for the slider value.
    _databaseReference.child("brightness").onValue.listen((event) {
      final value = event.snapshot.value;
      _brightness = (value is double) ? value : 0.0;
      notifyListeners(); // Notify listeners of the change
    });

    _databaseReference.child("sensor_value").onValue.listen((event) {
      final value = event.snapshot.value;
      _sensorValue = (value is double) ? value : 0.0;
      notifyListeners(); // Notify listeners of the change
    });

    // Load LED pin numbers and states from the database.
    for (String led in _ledPins.keys) {
      _databaseReference.child("$led Pin").onValue.listen((event) {
        final value = event.snapshot.value;
        _ledPins[led] = (value as String?) ?? '';
        notifyListeners(); // Notify listeners of the change
      });

      _databaseReference.child("$led State").onValue.listen((event) {
        final value = event.snapshot.value;
        _ledStates[led] = (value == 1);
        notifyListeners(); // Notify listeners of the change
      });

      // Load LED button titles from the database.
      _databaseReference.child("$led Button Title").onValue.listen((event) {
        final value = event.snapshot.value;
        _ledButtonTitles[led] = (value as String?) ?? '';
        notifyListeners(); // Notify listeners of the change
      });
    }
  }

  double get brightness => _brightness;
  double get sensorValue => _sensorValue;
  Map<String, String> get ledPins => _ledPins;
  Map<String, bool> get ledStates => _ledStates;
  Map<String, String> get ledButtonTitles => _ledButtonTitles;

  void updateBrightness(double value) {
    _databaseReference.child("brightness").set(value);
  }

  void updateLedPin(String led, String value) {
    _databaseReference.child("$led Pin").set(value);
  }

  void toggleLedState(String led, bool newState) {
    _databaseReference.child("$led State").set(newState ? 1 : 0);
  }

  void updateButtonTitle(String led, String title) {
    _databaseReference.child("$led Button Title").set(title);
  }
}