// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_list_with_firebase_13/screens/authentication_screens/login_types_screen.dart';
import 'package:to_do_list_with_firebase_13/screens/authentication_screens/sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Lottie.asset('assets/welcomelottie.json'),
            Text(
              'Hoş Geldiniz',
              style: TextStyle(
                  color: Colors.white, fontSize: 35, fontFamily: 'Itim'),
            ),
            SizedBox(height: 20),
            Container(
              width: 320,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFF512F),
                    Color(0xFFF09819),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 15,
                  shadowColor: Colors.orange.shade800,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TypesOfLoginPage(),
                    ),
                  );
                },
                child: Text(
                  'Giriş Yap',
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              width: 320,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFF512F),
                    Color(0xFFF09819),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 15,
                  shadowColor: Colors.orange.shade800,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ),
                  );
                },
                child: Text(
                  'Kayıt Ol',
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
