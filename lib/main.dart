import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ark_inventory/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main()  async
{
  WidgetsFlutterBinding.ensureInitialized();
 //sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        body:
        //apply_filters(),
        homepage(),
      ),
    );
  }
}

