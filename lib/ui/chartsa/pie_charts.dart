import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGuageScreen extends StatefulWidget {
  const RadialGuageScreen({super.key});

  @override
  State<RadialGuageScreen> createState() => _RadialGuageScreenState();
}

class _RadialGuageScreenState extends State<RadialGuageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(child: Text('Graph',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // You can customize this action based on your navigation requirements
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 150,
                interval: 10,
                ranges:<GaugeRange> [
                  GaugeRange(startValue: 0, endValue: 50,
                  color: Colors.green,),
                  GaugeRange(startValue: 50, endValue: 100,
                    color: Colors.yellow,),
                  GaugeRange(startValue: 100, endValue: 150,
                    color: Colors.red,)
                ],
                pointers:const <GaugePointer> [
                  NeedlePointer(
                    value: 90,
                    enableAnimation: true,
                  )
                ],
                annotations: const <GaugeAnnotation>[
                  GaugeAnnotation(widget: Text('90.0',style:
                  TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                  ),
                    positionFactor: 0.5,
                    angle: 90,
                  )
                ],
              )
            ],
          )
        ],
      ),

    );
  }
}
