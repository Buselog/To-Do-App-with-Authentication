// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_firebase_13/screens/authentication_screens/sign_up_screen.dart';
import 'package:to_do_list_with_firebase_13/services/on_board.dart';

import '../../services/auth.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _myKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<void> showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // başka yerlere basılırsa kapanmasın
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('E-Mail Doğrulama Hatırlatması'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Merhaba, lütfen mailinizi kontrol ediniz.'),
                  Text(
                      'Onay linkine tıklayarak mail adresinizi doğrulamalısınız'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Anladım'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0F2027),
                Color(0xFF203A43),
                Color(0xFF2C5364),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Lottie.asset('assets/loggin.json',
                    fit: BoxFit.cover, height: 190),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Form(
                    key: _myKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            validator: (emailData) {
                              if (!EmailValidator.validate(emailData!)) {
                                return 'Lütfen geçerli bir e-mail adresi giriniz';
                              } else {
                                return null;
                              }
                            },
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'E-mail',
                              labelStyle: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              hintText: 'E-mail adresinizi giriniz',
                              hintStyle: TextStyle(color: Colors.white38),
                              suffixIcon: Icon(
                                Icons.mail_outlined,
                                color: Color(0xFF134E5E),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white
                            ),
                          ),
                          TextFormField(
                            validator: (passwordData) {
                              if (passwordData!.length <= 5) {
                                return 'Lütfen daha uzun bir şifre giriniz';
                              } else {
                                return null;
                              }
                            },
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Şifre',
                              labelStyle: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              hintText: 'Şifrenizi giriniz',
                              hintStyle: TextStyle(color: Colors.white38),
                              suffixIcon: Icon(
                                Icons.lock_outlined,
                                color: Color(0xFF134E5E),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white
                            ),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            height: 60,
                            width: 300,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF134E5E),
                                  Color(0xFF536976),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(45),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                backgroundColor: Colors.transparent,
                                elevation: 5,
                                side:
                                    const BorderSide(color: Colors.white70),
                              ),
                              onPressed: () async {
                                if (_myKey.currentState!.validate()) {
                                  // her şey doğru girilmişse
                                  final user = await Provider.of<Auth>(
                                          context,listen: false)
                                      .signInWithEmailAndPassword(
                                          emailController.text,
                                          passwordController.text);
                                  if (!user!.emailVerified) {
                                    await showMyDialog();
                                    await Provider.of<Auth>(context, listen: false).signOut();
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const OnBoard(),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                'Giriş Yap',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
               const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 20, bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Hesabın yok mu ?',
                          style:
                              TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Kayıt Ol',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
