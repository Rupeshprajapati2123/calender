import 'package:calender/fresh.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import './firebase_options.dart';
import './methods.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TableCalendar Example',
      home: Calender(),
    );
  }
}

