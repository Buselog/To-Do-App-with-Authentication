// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_firebase_13/screens/authentication_screens/login_types_screen.dart';
import 'package:to_do_list_with_firebase_13/screens/authentication_screens/sign_in_screen.dart';
import '../../services/auth.dart';
import '../../services/on_board.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // başka yerlere basılırsa kapanmasın
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('E-Mail Doğrulama'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Merhaba, lütfen mailinizi kontrol ediniz.'),
                  Text(
                      'Onay linkine tıklayarak mail adresinizi doğrulamalısınız, aksi halde çıkış yapacaksınız'),
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
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.viewInsetsOf(context).bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/loggin.json',
                      fit: BoxFit.fill, height: 190),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Form(
                      key: _signUpKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Column(
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
                              keyboardType: TextInputType.emailAddress,
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
                            TextFormField(
                              validator: (confirmData) {
                                if (confirmData != passwordController.text) {
                                  return 'Girdiğiniz şifreler birbiriyle uyuşmuyor';
                                } else {
                                  return null;
                                }
                              },
                              controller: passwordController,
                              obscureText: true,
                              keyboardAppearance: Brightness.dark,
                              decoration: const InputDecoration(
                                labelText: 'Şifreyi Doğrula',
                                labelStyle: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                hintText: 'Şifreyi tekrar giriniz',
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
                            const SizedBox(height: 20),
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
                                  side: const BorderSide(color: Colors.white70),
                                ),
                                onPressed: () async {
                                  if (_signUpKey.currentState!.validate()) {
                                    // her şey doğru girilmişse
                                    final user =
                                        await Provider.of<Auth>(context, listen: false)
                                            .createNewUserWithEmailAndPassword(
                                                emailController.text,
                                                passwordController.text);
                                    if (!user!.emailVerified) {
                                      user.sendEmailVerification();
                                      await showMyDialog();
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignInPage(),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Kayıt Ol',
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
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Zaten bir hesabın var mı ?',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TypesOfLoginPage()),
                              );
                            },
                            child: const Text(
                              'Giriş Yap',
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
      ),
    );
  }
}
