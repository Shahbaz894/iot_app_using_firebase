import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';



class SensorReadingScreen extends StatelessWidget {
  final DatabaseReference databaseReference =
  FirebaseDatabase.instance.reference();

   SensorReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('IoT Control and Monitoring'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                stream: databaseReference.child("temperature").onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final temperature = snapshot.data!.snapshot.value.toString();
                    return Text('Temperature: $temperature °C');
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Text('Loading Temperature...');
                  }
                },
              ),
              StreamBuilder(
                stream: databaseReference.child("humidity").onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final humidity = snapshot.data!.snapshot.value.toString();
                    return Text('Humidity: $humidity %');
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Text('Loading Humidity...');
                  }
                },
              ),
              StreamBuilder(
                stream: databaseReference.child("pressure").onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final pressure = snapshot.data!.snapshot.value.toString();
                    return Text('Pressure: $pressure hPa');
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Text('Loading Pressure...');
                  }
                },
              ),
              StreamBuilder(
                stream: databaseReference.child("board1/outputs/digital").onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final digitalOutputs = snapshot.data!.snapshot.value as Map<String, dynamic>;

                    final ledStatus2 = digitalOutputs["2"] ?? 0;
                    final ledStatus13 = digitalOutputs["13"] ?? 0;
                    final ledStatus14 = digitalOutputs["14"] ?? 0;

                    return Column(
                      children: [
                        Switch(
                          value: ledStatus2 == 1,
                          onChanged: (newValue) {
                            _toggleLED("2", newValue ? 1 : 0);
                          },
                        ),
                        Switch(
                          value: ledStatus13 == 1,
                          onChanged: (newValue) {
                            _toggleLED("13", newValue ? 1 : 0);
                          },
                        ),
                        Switch(
                          value: ledStatus14 == 1,
                          onChanged: (newValue) {
                            _toggleLED("14", newValue ? 1 : 0);
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
  void _toggleLED(String outputPin, int value) {
    databaseReference.child("board1/outputs/digital").update({
      outputPin: value,
    });
  }

}
