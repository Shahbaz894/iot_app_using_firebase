import 'dart:ffi';


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iot_app_using_firebase/ui/screens/sensor_value.dart';
import 'package:provider/provider.dart';

import '../../domain/led_card.dart';
import 'app_data_provider.dart';
import 'led_control.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference databaseReference =
  FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LED Control and Sensor Data'),
      ),
      body:
      Column(
        children: <Widget>[
          SizedBox(height: 20),
          Consumer<AppDataProvider>(
            builder: (context, appData, child) {
              //print(appData.sliderValue);
              return Column(
                children: [
                  Text(
                    'Sensor Value: ${appData.sliderValue.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20),
                  ),

                ],
              );
            },
          ),

          Consumer<AppDataProvider>(
            builder: (context, appData, child) {
              return Slider(
                value: appData.sliderValue.toDouble(),
                onChanged: (newValue) {
                  context.read<AppDataProvider>().updateBrightness(newValue);
                },
                min: 0,
                max: 100,
                divisions: 100,
                label:appData.sliderValue.toString()
                //label: 'Brightness',
              );
            },
          ),

          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount:context.select((AppDataProvider appData) => appData.ledPins.length) ,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 4/4,
              crossAxisCount: 2

            ), itemBuilder: (BuildContext context, int index) {
        final ledPins = context.watch<AppDataProvider>().ledPins;
        final ledStates = context.watch<AppDataProvider>().ledStates;
        final ledTitles = context.watch<AppDataProvider>().ledTitles;

        String led = ledPins.keys.elementAt(index);
        String pin = ledPins[led] ?? '';
        bool isOn = ledStates[led] ?? false;
        String title = ledTitles[led] ?? ' ';

              return LedCard(
                led: led,
                pin: pin,
                isOn: isOn,
                title: title,
                onToggle: (newState) {
            context.read<AppDataProvider>().toggleLedState(led, newState);
          },
          onUpdatePin: (newPin) {
            context.read<AppDataProvider>().updateLedPin(led, newPin);
          },
          onEditPin: () {
            _showPinInputDialog(context, led, ledPins[led] ?? '');
          },
          buttonTitle: title.toString(),
          onUpdateButtonTitle: (String title) {
            context.read<AppDataProvider>().updateLedTitle(led, title);
          },
        );
      },
    ),
          ),



          StreamBuilder(
            stream: databaseReference.child("humidity").onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final int humidity = snapshot.data!.snapshot.value as int;
                return   SensorDataProgressBar(sensorValue:  humidity);
                  //Text('Humidity: $humidity %');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Loading Humidity...');
              }
            },
          ),
          // StreamBuilder(
          //   stream: databaseReference.child("humidity").onValue,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       final int humidity = snapshot.data!.snapshot.value as int;
          //       return   SensorDataProgressBar(sensorValue:  humidity);
          //       //Text('Humidity: $humidity %');
          //     } else if (snapshot.hasError) {
          //       return Text('Error: ${snapshot.error}');
          //     } else {
          //       return Text('Loading Humidity...');
          //     }
          //   },
          // ),


          // SensorDataProgressBar(sensorValue: 75)

        ],
      ),
    );
  }

  void _showPinInputDialog(BuildContext context, String led, String currentPin) async {
    TextEditingController pinController = TextEditingController(text: currentPin);
    TextEditingController pinTitleController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            title: Text('Enter Pin for $led'),
            content: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                    color: Colors.green,
                border: Border.all(
                  color: Colors.black45
                )
              ),

              child: Column(
                children: [
                  TextField(
                    controller: pinController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Pin Number'),
                  ),
                  TextField(
                    controller: pinTitleController,
                    decoration: const InputDecoration(labelText: 'Switch Title'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  String newPin = pinController.text;
                  context.read<AppDataProvider>().updateLedPin(led, newPin);
                  String newPinTitle = pinTitleController.text;
                  context.read<AppDataProvider>().updateLedTitle(led, newPinTitle);
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
