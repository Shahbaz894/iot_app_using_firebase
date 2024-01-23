import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../ui/chartsa/radial_guage.dart';

class StreamBuilderWidget extends StatelessWidget {
  final DatabaseReference reference;
  final String gaugeTitle;

  const StreamBuilderWidget({
    required this.reference,
    required this.gaugeTitle,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: reference.onValue,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var userData = snapshot.data?.snapshot.value;
          if (userData == null || !(userData is Map)) {
            return Text('Invalid data format');
          }
          dynamic value = userData[gaugeTitle.toLowerCase()] ?? 0.0;

          if (value is int) {
            value = value.toDouble(); // Convert int to double
          }

          return Expanded(
            child: SizedBox(
              height: 370,
              width: 100,
              child: RadialGuageScreen(
                pointerValue: value,
                guageTitle: gaugeTitle,
              ),
            ),
          );
        }
      },
    );
  }
}
