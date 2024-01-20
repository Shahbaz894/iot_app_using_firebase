import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SensorDataProgressBar extends StatefulWidget {
  final int sensorValue; // Replace with your sensor data

  SensorDataProgressBar({required this.sensorValue});

  @override
  State<SensorDataProgressBar> createState() => _SensorDataProgressBarState();
}

class _SensorDataProgressBarState extends State<SensorDataProgressBar> {
  @override
  Widget build(BuildContext context) {
    // Calculate the percentage based on your sensor data range (e.g., 0 to 100)
    double percentage = widget.sensorValue / 100;

    return Center(
      child: CircularPercentIndicator(
        radius: 200.0, // Adjust the size as needed
        lineWidth: 20.0, // Adjust the thickness of the progress bar
        percent: percentage,
        animation: true,
        animationDuration: 2000, // Duration of the animation
        center: Text(
          "${'Humidity:' +widget.sensorValue.toStringAsFixed(1)}%", // Display the sensor value as text
          style: TextStyle(fontSize: 20.0),
        ),
        circularStrokeCap: CircularStrokeCap.round, // Choose a cap style
        progressColor: Colors.red,
        // Color of the progress bar
      ),
    );
  }
}
