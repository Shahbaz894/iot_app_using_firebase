import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class LedCard extends StatelessWidget {
  final String led;
  final String pin;
  final String buttonTitle;
  final String title;
  final bool isOn;
  final Function(bool) onToggle;
  final Function(String) onUpdatePin;
  final Function(String) onUpdateButtonTitle;
  final VoidCallback onEditPin;


  LedCard({
    required this.led,
    required this.pin,
    required this.buttonTitle,
    required this.isOn,
    required this.onToggle,
    required this.onUpdatePin,
    required this.onUpdateButtonTitle,
    required this.onEditPin,
    required  this.title,
  });

  @override

Widget build(BuildContext context) {
    return Container(

      height: 100,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Card(
        color: isOn ? Colors.green : Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: onEditPin,
                ),
                Text(
                  '$title is ${isOn ? 'On' : 'Off'}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),

            Switch(
              value: isOn,
              onChanged: onToggle,
            ),
          ],
        ),
      ),
    );
  }
}





















