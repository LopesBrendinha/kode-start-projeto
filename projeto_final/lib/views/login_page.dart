import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
          Navigator.pushReplacementNamed(context, "/home");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          throw Exception('Usuário não encontrado.');
        } else if (e.code == 'wrong-password') {
          throw Exception('Senha incorreta.');
        } else {
          throw Exception('Erro ao fazer login: ${e.message}');
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

        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(credential);

        final user = userCredential.user;

        if (user != null) {
          await FirebaseFirestore.instance
              .collection('usuarios')
              .doc(user.uid)
              .set({
                'nome': user.displayName ?? '',
                'email': user.email ?? '',
                'foto': user.photoURL ?? '',
                'createdAt': DateTime.now(),
              });

          Navigator.pushReplacementNamed(context, "/home");
        }

        return userCredential;
      } catch (e) {
        print("Erro no login com Google: $e");
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
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(
                      AppImages.logoSplash,
                      height: 240 * 0.8,
                      width: 290 * 0.8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _email,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: "E-mail",
                                labelStyle: const TextStyle(color: Colors.white),
                                prefixIcon: Icon(Icons.email, color: AppColors.primaryColorLight),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _password,
                              obscureText: _obscure,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: const TextStyle(color: Colors.white),
                                prefixIcon: Icon(Icons.lock, color: AppColors.primaryColorLight),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscure ? Icons.visibility_off : Icons.visibility,
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
                                  minimumSize: const Size(175, 50)
                                ),
                                child: const Text("Login", style: TextStyle(fontSize: 18, color: Colors.white)),
                              ),
                              SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: signIn,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColorLight,
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  minimumSize: const Size(175, 50)
                                ),
                                child: const Text("Sign Up", style: TextStyle(fontSize: 18, color: Colors.white)),
                              ),
                              ] 
                              
                                
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
