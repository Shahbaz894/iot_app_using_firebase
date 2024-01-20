// import 'package:flutter/material.dart';
// import 'package:iot_app_using_firebase/ui/screens/sensor_value.dart';
// import 'package:provider/provider.dart';
//
// import '../../domain/led_card.dart';
// import 'data/appdata_provider.dart';
//
//
//
// class HomeScreen extends StatelessWidget {
//   get currentPinTitle => null;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('LED Control and Sensor Data'),
//       ),
//       body: Column(
//         children: <Widget>[
//           SizedBox(height: 20),
//           Consumer<AppDataProvider>(
//             builder: (context, appData, child) {
//               return Text(
//                 'Sensor Value: ${appData.sensorValue.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 20),
//               );
//             },
//           ),
//           Consumer<AppDataProvider>(
//             builder: (context, appData, child) {
//               return Slider(
//                 value: appData.brightness,
//                 onChanged: (newValue) {
//                   context.read<AppDataProvider>().updateBrightness(newValue);
//                 },
//                 min: 0,
//                 max: 100,
//                 divisions: 100,
//                 label: 'Brightness',
//               );
//             },
//           ),
//           SizedBox(height: 20),
//           Expanded(
//             child: GridView.builder(
//               //scrollDirection: Axis.vertical,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 20,
//                 crossAxisSpacing: 20,
//                 childAspectRatio: 12/3,
//               ),
//               itemCount: context.select((AppDataProvider appData) => appData.ledPins.length),
//               itemBuilder: (BuildContext context, int index) {
//                 final ledPins = context.watch<AppDataProvider>().ledPins;
//                 final ledStates = context.watch<AppDataProvider>().ledStates;
//                 final ledTitles = context.watch<AppDataProvider>().ledTitles;
//
//                 String led = ledPins.keys.elementAt(index);
//                 String pin = ledPins[led] ?? '';
//                 bool isOn = ledStates[led] ?? false;
//                 String title = ledTitles[led] ?? 'Default Title';
//
//                 return LedCard(
//                   led: led,
//                   pin: pin,
//                   isOn: isOn,
//                   title:title,
//                   onToggle: (newState) {
//                     context.read<AppDataProvider>().toggleLedState(led, newState);
//                   },
//                   onUpdatePin: (newPin) {
//                     context.read<AppDataProvider>().updateLedPin(led, newPin);
//                   },
//                   onEditPin: () {
//                     _showPinInputDialog(context, led, ledPins[led] ?? '',);
//                   },
//                   buttonTitle: title.toString(),
//                   onUpdateButtonTitle: (String title ) {
//                     context.read<AppDataProvider>().updateLedTitle(led, ledTitles.toString());
//                   },
//                 );
//               },
//             ),
//           ),
//           Spacer(),
//           SensorDataProgressBar(sensorValue: 75)
//
//         ],
//       ),
//     );
//   }
//
//   void _showPinInputDialog(BuildContext context, String led, String currentPin) async {
//     TextEditingController pinController = TextEditingController(text: currentPin);
//     TextEditingController pinTitleController = TextEditingController(text: currentPinTitle);
//
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Enter Pin for $led'),
//           content:
//           Column(
//             children: [
//               TextField(
//                 controller: pinController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Pin Number'),
//
//               ),
//               TextField(
//                 controller: pinTitleController,
//                 //keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText:'Switch Title' ),
//
//               ),
//             ],
//           ),
//
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 String newPin = pinController.text;
//                 context.read<AppDataProvider>().updateLedPin(led, newPin);
//                 String newPinTitle = pinTitleController.text;
//                 context.read<AppDataProvider>().updateLedTitle(led, newPinTitle);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Save'),
//             ),
//             // TextButton(
//             //   onPressed: () {
//             //     String newTitle = pinTitleController.text;
//             //     context.read<AppDataProvider>().updateLedTitle(led,newTitle );
//             //     Navigator.of(context).pop();
//             //   },
//             //   child: Text('Save'),
//             // ),
//           ],
//         );
//       },
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
