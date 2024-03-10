// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_firebase_13/models/note_data.dart';
import 'package:to_do_list_with_firebase_13/services/auth.dart';
import 'package:to_do_list_with_firebase_13/services/on_board.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteData().createPrefObject();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyB8nqaIYQBMVhi6370fQIxJv-BiHPtphlw',
        appId: "1:6906617099:android:4b3b17c2b0633b3988160e",
        messagingSenderId: "6906617099",
        projectId: "to-do-app-25702"),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteData()),
        Provider(create: (context) => Auth()),

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<NoteData>(context).loadNotesFromSharedPref();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyLottieAnimation(),
      ),
    );
  }
}

class MyLottieAnimation extends StatefulWidget {
  const MyLottieAnimation({super.key});

  @override
  State<MyLottieAnimation> createState() => _MyLottieAnimationState();
}

class _MyLottieAnimationState extends State<MyLottieAnimation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OnBoard()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [
              Color(0xFF0F2027),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ],
          ),
        ),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/todolottie.json'),
                SizedBox(height: 40),
                Text(
                  'G   e   t      I  t      D   o   n   e',
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      shadows: const <Shadow>[
                        Shadow(
                          color: Color(0xFFF7EED2),
                          blurRadius: 3,
                        ),
                      ],
                      fontFamily: 'assets/Nunito-Italic-VariableFont_wght.ttf'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
