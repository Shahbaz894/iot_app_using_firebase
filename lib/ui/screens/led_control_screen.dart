

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iot_app_using_firebase/ui/screens/slider_block_widget.dart';
import 'package:iot_app_using_firebase/ui/screens/switch_bloc_screen.dart';
import 'package:iot_app_using_firebase/ui/screens/widgets/drawer.dart';

import '../../uitils/streambuilder.dart';


class LedControlScreen extends StatelessWidget {
  final DatabaseReference _ledRef2 =
  FirebaseDatabase.instance.reference().child('board1/outputs/digital/2');
  final DatabaseReference _ledRef13 =
  FirebaseDatabase.instance.reference().child('board1/outputs/digital/13');
  final DatabaseReference _ledRef14 =
  FirebaseDatabase.instance.reference().child('board1/outputs/digital/14');
  final DatabaseReference _temperatureRef =
  FirebaseDatabase.instance.reference().child('UsersData');
  final DatabaseReference _humidity =
  FirebaseDatabase.instance.reference().child('UsersData');
  final DatabaseReference _slider =
  FirebaseDatabase.instance.reference().child('UsersData');

  @override
  Widget build(BuildContext context) {
    bool isLedOn = _ledRef2.onValue == 1;
    bool isLedon2 = _ledRef13.onValue == 1;
    double sliderValue = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(
          child: Text(
            'Firebase LED Control',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                StreamBuilderWidget(
                  reference: _temperatureRef,
                  gaugeTitle: 'Temperature',
                ),
                const SizedBox(
                  width: 5,
                ),
                StreamBuilderWidget(
                  reference: _humidity,
                  gaugeTitle: 'Humidity',
                ),
                const SizedBox(
                  width: 5,
                ),
                // ... Add more StreamBuilderWidget instances for other data sources

              ],
            )

          //  Row(children: [
          //   Expanded(child: SwitchBlocWidget(ledRef: _ledRef2,isLedOn: isLedOn)),
          //   Expanded(child: SwitchBlocWidget(ledRef: _ledRef13,isLedOn: isLedon2)),
          // ],),
           // Row(children: [
           //    Expanded(child: SwitchBlocWidget(ledRef: _ledRef14,)),
           //    Expanded(child: SwitchBlocWidget(ledRef: _ledRef14,)),
           //  ],),
            SliderBlocWidget()


          ],
        ),
      ),
    );
  }
}
