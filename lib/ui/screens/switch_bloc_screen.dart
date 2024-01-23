import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/switch_bloc.dart';
import '../../bloc/switch_events.dart';
import '../../bloc/switch_state.dart';

class SwitchBlocWidget extends StatelessWidget {
  final DatabaseReference ledRef;
  final bool isLedOn;
  const SwitchBlocWidget({Key? key, required this.ledRef,required this.isLedOn}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseDatabase.instance.reference().child('brightness');
    final SwitchBloc switchBloc = BlocProvider.of<SwitchBloc>(context);

    return Center(
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Switch is ${state.switchValue ? 'ON' : 'OFF'}',
                  style: TextStyle(
                      fontSize: 20,
                      color: state.switchValue ? Colors.red : Colors.green),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 120,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(130),
                    color: Colors.green,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        size: 50,
                        color: state.switchValue ? Colors.red : Colors.yellow,
                      ),
                      Switch(
                        value: state.switchValue,
                        onChanged: (newValue) {
                          ledRef.set(newValue ? 1 : 0); // Update Firebase value
                          context.read<SwitchBloc>().add(SwitchOnOffEvent());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
