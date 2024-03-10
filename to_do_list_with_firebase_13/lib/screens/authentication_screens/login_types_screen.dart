import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_firebase_13/screens/authentication_screens/sign_in_screen.dart';
import 'package:to_do_list_with_firebase_13/services/on_board.dart';
import '../../services/auth.dart';

class TypesOfLoginPage extends StatefulWidget {
  const TypesOfLoginPage({super.key});

  @override
  State<TypesOfLoginPage> createState() => _TypesOfLoginPageState();
}

class _TypesOfLoginPageState extends State<TypesOfLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F2027),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ],
          ),
        ),
        child: Column(
          children: [
            Lottie.asset('assets/typeoflogin.json', fit: BoxFit.fill),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    backgroundColor: const Color(0xFF414d0b),
                    elevation: 3,
                    side: const BorderSide(color: Colors.white70, width: 0.5)),
                onPressed: () {
                  Provider.of<Auth>(context, listen: false).signInAnonymously();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnBoard(),
                    ),
                  );
                },
                child: const Text(
                  'Anonim Giriş Yap',
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  backgroundColor: const Color(0xFF200122),
                  elevation: 3,
                  side: const BorderSide(color: Colors.white70, width: 0.5),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInPage(),
                    ),
                  );
                },
                child: const Text(
                  'E-mail & Şifre ile Giriş Yap',
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  backgroundColor: const Color(0xFF6f0000),
                  elevation: 3,
                  side: const BorderSide(color: Colors.white70, width: 0.5),
                ),
                onPressed: () {
                  Provider.of<Auth>(context, listen: false).signInWithGoogle();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnBoard(),
                    ),
                  );
                },
                child: const Text(
                  'Google ile Giriş Yap',
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
