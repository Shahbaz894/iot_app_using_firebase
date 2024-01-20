import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

// Define a class to hold the app state
class AppDataProvider extends ChangeNotifier {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  int _brightness = 0;
  int _sliderValue = 0;
  int _sensorValue2=0;
  int progessIndicator=0;

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

  // Constructor
  AppDataProvider() {
    // ... Previous code ...

    // Load LED titles, pin numbers, and states from the database.
    for (String led in _ledPins.keys) {
      _databaseReference.child("$led Title").onValue.listen((event) {
        final value = event.snapshot.value;
        _ledTitles[led] = (value as String?) ?? ' Title';
        notifyListeners(); // Notify listeners of the change
      });

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
      _databaseReference.child('sensorValue2').onValue.listen((event) {
    final value =event.snapshot.value;
    _sensorValue2=(value as int ) ;
    notifyListeners();

      });
      _databaseReference.child('brightness').onValue.listen((event) {
        final value =event.snapshot.value;
        _sliderValue=(value as int);
        notifyListeners();

      });
    }
  }

  // Add a map to store LED titles
  Map<String, String> _ledTitles = {
    'LED 1': '',
    'LED 2': ' Title ',
    'LED 3': 'Title ',
    'LED 4': ' Title ',
  };

  int get brightness => _brightness;
  int get sliderValue => _sliderValue;
  int get sensorValue2 => _sensorValue2;
  Map<String, String> get ledPins => _ledPins;
  Map<String, bool> get ledStates => _ledStates;
  Map<String, String> get ledTitles => _ledTitles;

  void updateBrightness(double value) {
    _databaseReference.child("brightness").set(value);
    notifyListeners();
  }

  void updateLedTitle(String led, String value) {
    _databaseReference.child("$led Title").set(value);
    notifyListeners();
  }

  void updateLedPin(String led, String value) {
    _databaseReference.child("$led Pin").set(value);
    notifyListeners();
  }

  void toggleLedState(String led, bool newState) {
    _databaseReference.child("$led State").set(newState ? 1 : 0);
    notifyListeners();
  }

}















//
