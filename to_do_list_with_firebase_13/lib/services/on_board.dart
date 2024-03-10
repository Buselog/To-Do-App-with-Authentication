// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_firebase_13/screens/authentication_screens/welcome_screen.dart';
import '../screens/to_do_screens/home_page.dart';
import 'auth.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: false);

    return StreamBuilder(
        stream: _auth.userSituation(), // bunu dinle
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.connectionState == ConnectionState.active) {
            return snapshot.data != null
                ? const HomePage()
                : const WelcomeScreen();
          } else {
            return const SizedBox(
              height: 300,
              width: 300,
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
