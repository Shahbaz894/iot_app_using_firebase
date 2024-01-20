import 'package:flutter/material.dart';
import 'package:iot_app_using_firebase/ui/auth_screen/login_screen.dart';
import 'package:iot_app_using_firebase/ui/chartsa/pie_charts.dart';

import '../../chartsa/line_chart.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  // You can add your user profile image here
                  // backgroundImage: NetworkImage('https://example.com/your_image.jpg'),
                ),
                SizedBox(height: 10),
                Text(
                  'Shahbaz Zulfiqar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Shahbaz@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Navigate to the home screen
              Navigator.pop(context); // Close the drawer
              // Add your navigation logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.show_chart),
            title: const Text('Charts'),
            onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>const RadialGuageScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.stacked_line_chart),
            title: const Text('Line Charts'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LineChart()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to the settings screen
              Navigator.pop(context); // Close the drawer
              // Add your navigation logic here
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Implement your logout logic
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));// Close the drawer
              // Add your logout logic here
            },
          ),
        ],
      ),
    );
  }
}
