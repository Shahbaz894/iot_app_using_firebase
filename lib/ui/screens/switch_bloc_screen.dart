import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app_using_firebase/bloc/switch_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_app_using_firebase/bloc/switch_events.dart';

import '../../bloc/switch_state.dart';

class SwitchBlocScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DatabaseReference _ledRef2 = FirebaseDatabase.instance.reference().child('board1/outputs/digital/2');
    final DatabaseReference _slider = FirebaseDatabase.instance.reference().child('brightness');
    final SwitchBloc switchBloc = BlocProvider.of<SwitchBloc>(context);

    return Scaffold(

      body: Center(
        child: BlocBuilder<SwitchBloc, SwitchState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Switch is ${state.switchValue ? 'ON' : 'OFF'}',
                    style: TextStyle(fontSize: 20, color: state.switchValue ? Colors.red : Colors.green),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green,
                      //color: state.switchValue ? Colors.red : Colors.green,
                      border: Border.all(color: Colors.black),

                    ),
                    child: Column(
                      children: [
                         Icon(
                          Icons.lightbulb, // Replace with the desired icon
                          size: 50,
                          color: state.switchValue ? Colors.red : Colors.yellow,
                        ),
                        Switch(
                          value: state.switchValue,
                          onChanged: (newValue) {
                            // Update the Firebase value when the switch is toggled
                            _ledRef2.set(newValue ? 1 : 0);

                            // Dispatch the Bloc event
                            context.read<SwitchBloc>().add(SwitchOnOffEvent());
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Slider(
                    value: state.slider,
                    onChanged: (value) {
                      // Ensure the slider value is between 0 and 100
                      value = value.clamp(0.0, 100.0);

                      // Update the Firebase value when the slider is changed
                      _slider.set(value);

                      // Dispatch the Bloc event
                      context.read<SwitchBloc>().add(SliderEvent(slider: value));
                    },
                  ),
                  Text('Slider Value: ${state.slider.toStringAsFixed(2)}'), // Display slider value


                  // Slider(
                  //   value: state.slider,
                  //   onChanged: (value) {
                  //     // Ensure the slider value is between 0 and 100
                  //     value = value.clamp(0.0, 100.0);
                  //
                  //     // Update the Firebase value when the slider is changed
                  //     _slider.set(value);
                  //
                  //     // Dispatch the Bloc event
                  //     context.read<SwitchBloc>().add(SliderEvent(slider: value));
                  //   },
                  // ),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
