import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app_using_firebase/bloc/switch_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_app_using_firebase/bloc/switch_events.dart';

import '../../bloc/switch_state.dart';

class SliderBlocWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DatabaseReference _ledRef2 = FirebaseDatabase.instance.reference().child('board1/outputs/digital/2');
    final DatabaseReference _slider = FirebaseDatabase.instance.reference().child('brightness');
    final SwitchBloc switchBloc = BlocProvider.of<SwitchBloc>(context);

    return Center(
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

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

              ],
            ),
          );
        },
      ),
    );
  }
}
