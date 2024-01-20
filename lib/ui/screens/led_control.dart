import 'package:firebase_database/firebase_database.dart';

class LedController {
  final DatabaseReference databaseReference;

  LedController(this.databaseReference);

  void setupLedControl() {
    databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value.toString();
        final parts = data.split(":");
        if (parts.length == 2) {
          final int? pin = int.tryParse(parts[0]);
          final int? value = int.tryParse(parts[1]);
          if (pin != null && value != null) {
            controlLed(pin, value);
          }
        }
      }
    });
  }

  void controlLed(int pin, int value) {
    switch (pin) {
      case 2:
      // Control LED connected to pin 2
        if (value == 1) {
          // Turn on the LED
        } else {
          // Turn off the LED
        }
        break;
      case 13:
      // Control LED connected to pin 13
        if (value == 1) {
          // Turn on the LED
        } else {
          // Turn off the LED
        }
        break;
      case 14:
      // Control LED connected to pin 14
        if (value == 1) {
          // Turn on the LED
        } else {
          // Turn off the LED
        }
        break;
      default:
      // Handle other pins or values as needed
        break;
    }
  }
}



