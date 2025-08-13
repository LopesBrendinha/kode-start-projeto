import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_final/theme/app_colors.dart';
import 'package:projeto_final/theme/app_images.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscure = true;

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacementNamed(context, "/homePage");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception(translate('login.errors.user_not_found'));
      } else if (e.code == 'wrong-password') {
        throw Exception(translate('login.errors.wrong_password'));
      } else {
        throw Exception('${translate('login.errors.generic')}: ${e.message}');
      }
    }
  }

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = 
          await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;
      if (user != null) {
        String? photoBase64;
        if (user.photoURL != null) {
          try {
            final response = await http.get(Uri.parse(user.photoURL!));
            if (response.statusCode == 200) {
              photoBase64 = base64Encode(response.bodyBytes);
            }
          } catch (e) {
            print(translate('login.errors.photo_conversion'));
          }
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
              'nome': user.displayName ?? '',
              'email': user.email ?? '',
              'photoBase64': photoBase64 ?? '', 
              'createdAt': DateTime.now(),
            });

        Navigator.pushReplacementNamed(context, "/homePage");
      }

      return userCredential;
    } catch (e) {
      print("${translate('login.errors.google_signin')}: $e");
      return null;
    }
  }

  void _toggleObscure() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBarColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Image.asset(
                        AppImages.logoSplash,
                        height: 240,
                        width: 290,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _email,
                                style: TextStyle(color: AppColors.white),
                                decoration: InputDecoration(
                                  labelText: translate('login.email_label'),
                                  labelStyle: TextStyle(color: AppColors.white),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: AppColors.primaryColorLight,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _password,
                                obscureText: _obscure,
                                style: TextStyle(color: AppColors.white),
                                decoration: InputDecoration(
                                  labelText: translate('login.password_label'),
                                  labelStyle: TextStyle(color: AppColors.white),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: AppColors.primaryColorLight,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppColors.primaryColorLight,
                                    ),
                                    onPressed: _toggleObscure,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: signIn,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColorLight,
                                      padding: const EdgeInsets.symmetric(vertical: 15),
                                      minimumSize: const Size(175, 50),
                                    ),
                                    child: Text(
                                      translate('login.login_button'),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.white,
                                        fontFamily: "Lato"
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pushReplacementNamed(context, "/signupPage"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColorLight,
                                      padding: const EdgeInsets.symmetric(vertical: 15),
                                      minimumSize: const Size(175, 50),
                                    ),
                                    child: Text(
                                      translate('login.signup_button'),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.white,
                                        fontFamily: "Lato"
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    translate('login.social_divider'),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Lato"
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SignInButton.mini(
                                        buttonType: ButtonType.google,
                                        onPressed: () => signInWithGoogle(context),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}