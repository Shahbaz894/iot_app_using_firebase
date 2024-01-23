import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGuageScreen extends StatefulWidget {
  final double? pointerValue;
  final String? guageTitle;
  const RadialGuageScreen({super.key, this.pointerValue,this.guageTitle});

  @override
  State<RadialGuageScreen> createState() => _RadialGuageScreenState();
}

class _RadialGuageScreenState extends State<RadialGuageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      //   title: const Center(child: Text('Graph',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.of(context).pop(); // You can customize this action based on your navigation requirements
      //     },
      //   ),
      // ),
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
                pointers: <GaugePointer> [
                  NeedlePointer(
                    value: widget.pointerValue ?? 0,
                    enableAnimation: true,
                  ),

                ],
                annotations:  <GaugeAnnotation>[
                  GaugeAnnotation(widget: Padding(
                    padding: const EdgeInsets.only(top: 170.0),
                    child: Column(
                      children: [
                        Text(
                          '${widget.pointerValue ?? 0}',
                          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.guageTitle ?? 'Gauge',
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),


                    positionFactor: 0.5,
                    angle:90,
                  )
                ],

              ),

            ],

          )
        ],
      ),

    );
  }
}
