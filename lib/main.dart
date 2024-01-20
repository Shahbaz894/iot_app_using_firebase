
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_app_using_firebase/ui/auth_screen/login_screen.dart';
import 'package:iot_app_using_firebase/ui/chartsa/pie_charts.dart';
import 'package:iot_app_using_firebase/ui/iot_screen.dart';
import 'package:iot_app_using_firebase/ui/screens/app_data_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:iot_app_using_firebase/ui/screens/home_screen.dart';
import 'package:iot_app_using_firebase/ui/screens/hpme_control_button.dart';
import 'package:iot_app_using_firebase/ui/screens/led_control_screen.dart';
import 'package:iot_app_using_firebase/ui/screens/switch_bloc_screen.dart';
import 'package:iot_app_using_firebase/ui/screens/switch_screen.dart';
import 'package:provider/provider.dart';

import 'bloc/switch_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD8EatFFINeZp9cvoqcfVQsOD1KS2U9FYA",
      appId: "1:76628789109:android:1d48b11f0699248eb4f53c",

      projectId: "shahbaziotapp",
      messagingSenderId: '76628789109',
      databaseURL: "https://shahbaziotapp-default-rtdb.firebaseio.com/",

    ),
  );
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppDataProvider()),
          //ChangeNotifierProvider(create: (_) => CartProvider()),
        ],

        child: MyApp(),)
  );


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [

        BlocProvider<SwitchBloc>(
          create: (_) => SwitchBloc(),
        ),
      ],
      child: MaterialApp(
        home:  LedControlScreen(),
      ),
    );

  }
}


// #define WIFI_SSID "City Cable Ryk"
// #define WIFI_PASSWORD "Sarmadwali525"
// #define FIREBASE_HOST "https://shahbaziotapp-default-rtdb.firebaseio.com"
// #define FIREBASE_AUTH "AIzaSyD8EatFFINeZp9cvoqcfVQsOD1KS2U9FYA"


// apiKey: "AIzaSyD8EatFFINeZp9cvoqcfVQsOD1KS2U9FYA",
// appId: "1:76628789109:android:1d48b11f0699248eb4f53c",
//
// projectId: "shahbaziotapp",
// messagingSenderId: '76628789109',
// databaseURL: "https://shahbaziotapp-default-rtdb.firebaseio.com/",