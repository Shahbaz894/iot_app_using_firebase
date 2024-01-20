import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iot_app_using_firebase/ui/screens/switch_bloc_screen.dart';
import 'package:iot_app_using_firebase/ui/screens/widgets/drawer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';



class LedControlScreen extends StatelessWidget {
  final DatabaseReference _ledRef2 = FirebaseDatabase.instance.reference().child('board1/outputs/digital/2');
  final DatabaseReference _ledRef13 = FirebaseDatabase.instance.reference().child('board1/outputs/digital/13');
  final DatabaseReference _ledRef14 = FirebaseDatabase.instance.reference().child('board1/outputs/digital/14');
  final DatabaseReference _temperatureRef = FirebaseDatabase.instance.reference().child('UsersData');
  final DatabaseReference _humidity = FirebaseDatabase.instance.reference().child('UsersData');
  final DatabaseReference _slider = FirebaseDatabase.instance.reference().child('UsersData');

  @override
  Widget build(BuildContext context) {
    bool isLedOn = _ledRef2.onValue==1;
    double sliderValue=0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(child: const Text('Firebase LED Control',style: TextStyle(fontWeight: FontWeight.bold),)),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [
           Padding(
             padding: const EdgeInsets.only(top: 40.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [

                 StreamBuilder(
                     stream: _temperatureRef.onValue,
                     builder: (context,AsyncSnapshot snapshot){
                       if (snapshot.connectionState == ConnectionState.waiting) {
                         return CircularProgressIndicator(); // Show a circular progress indicator while loading
                       } else if (snapshot.hasError) {
                         return Text('Error: ${snapshot.error}');
                       }else{
                         var userData = snapshot.data?.snapshot.value;
                         if (userData == null || !(userData is Map)) {
                           return Text('Invalid data format');
                         }
                         double temperature = userData['temperature'] ?? 0.0;
                         //double temperature = double.tryParse(snapshot.data?.snapshot.value?.toString() ?? '') ?? 0.0;
                         //print(temperature);
                         return
                           CircularPercentIndicator(
                             radius: 150.0,
                             lineWidth: 15.0,
                             percent: temperature.clamp(0, 100).toDouble() / 100.0,
                             //percent: 1.0,
                             center: Text('Temperature: $temperature°C'),
                             progressColor: getProgressColor(temperature),
                           );


                       }

                     }),


               SizedBox(width: 10,),
                 StreamBuilder(
                   stream: _humidity.onValue,
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
                       // Convert the humidity value to double
                       double humidity = (userData['humidity'] ?? 0).toDouble();

                       return CircularPercentIndicator(
                         radius: 150.0,
                         lineWidth: 10.0,
                         percent: humidity.clamp(0, 100) / 100.0,
                         center: Text('humidity: $humidity'),
                         progressColor: Colors.green,
                       );
                     }
                   },
                 )


               ],),
           ),
            SizedBox(width: 10,),
            StreamBuilder(
              stream: _humidity.onValue,
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
                  // Convert the humidity value to double
                  double humidity = (userData['pressure'] ?? 0).toDouble();

                  return CircularPercentIndicator(
                    radius: 150.0,
                    lineWidth: 10.0,
                    percent: humidity.clamp(0, 100) / 100.0,
                    center: Text('Pressure: $humidity'),
                    progressColor: Colors.green,
                  );
                }
              },
            ),



            SizedBox(height: 10,),
       Expanded(child: SwitchBlocScreen()),



          ],
        ),
      ),
    );
  }

  getProgressColor(double temperature) {
    if (temperature <= 10) {
      return Colors.blue; // Set the color based on a temperature range
    } else if (temperature <= 20) {
      return Colors.green;
    } else if (temperature <= 30) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}


