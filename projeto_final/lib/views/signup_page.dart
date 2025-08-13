import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_final/theme/app_colors.dart';
import 'package:projeto_final/theme/app_images.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? _selectedImage;
  bool _obscure = true;

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await ImagePicker()
          .pickImage(
            source: ImageSource.gallery,
            maxWidth: 800,
            maxHeight: 800,
            imageQuality: 85,
          )
          .catchError((error) {
            debugPrint(translate('signup.errors.image_picker'));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate('signup.errors.gallery_access')),
                backgroundColor: AppColors.red,
              ),
            );
            return null;
          });

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint(translate('signup.errors.unexpected'));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(translate('signup.errors.unexpected_message')),
          backgroundColor: AppColors.red,
        ),
      );
    }
  }

  Future<void> register() async {
    if (_name.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(translate('signup.errors.name_required')),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    if (_email.text.isEmpty || !_email.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(translate('signup.errors.valid_email')),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    if (_password.text.isEmpty || _password.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(translate('signup.errors.password_length')),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(translate('signup.creating_account')),
          ],
        ),
      ),
    );

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _email.text,
            password: _password.text,
          );

      String uid = userCredential.user!.uid;
      String? imageBase64;

      if (_selectedImage != null) {
        List<int> imageBytes = await _selectedImage!.readAsBytes();
        imageBase64 = base64Encode(imageBytes);

        if (imageBytes.length > 500000) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(translate('signup.errors.image_too_large')),
              backgroundColor: AppColors.gray,
            ),
          );
          Navigator.of(context, rootNavigator: true).pop();
          return;
        }
      }

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': _name.text.trim(),
        'email': _email.text.trim(),
        'photoBase64': imageBase64 ?? '',
        'createdAt': DateTime.now(),
      });

      Navigator.of(context, rootNavigator: true).pop();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(translate('signup.success.title')),
          content: Text(translate('signup.success.message')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (FirebaseAuth.instance.currentUser != null) {
                  Navigator.pushReplacementNamed(context, "/homePage");
                }
              },
              child: Text(translate('signup.success.ok_button')),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();

      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = translate('signup.errors.weak_password');
          break;
        case 'email-already-in-use':
          errorMessage = translate('signup.errors.email_in_use');
          break;
        case 'invalid-email':
          errorMessage = translate('signup.errors.invalid_email');
          break;
        default:
          errorMessage = '${translate('signup.errors.registration_failed')}: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: AppColors.red),
      );
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${translate('signup.errors.generic')}: $e'),
          backgroundColor: AppColors.red,
        ),
      );
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Image.asset(
                        AppImages.logoSplash,
                        height: 240,
                        width: 290,
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _selectedImage != null
                              ? MemoryImage(
                                  base64Decode(
                                    base64Encode(
                                      _selectedImage!.readAsBytesSync(),
                                    ),
                                  ),
                                )
                              : null,
                          child: _selectedImage == null
                              ? const Icon(Icons.add_a_photo, size: 30)
                              : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _name,
                                style: TextStyle(color: AppColors.white),
                                decoration: InputDecoration(
                                  labelText: translate('signup.name_label'),
                                  labelStyle: TextStyle(color: AppColors.white),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: AppColors.primaryColorLight,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _email,
                                style: TextStyle(color: AppColors.white),
                                decoration: InputDecoration(
                                  labelText: translate('signup.email_label'),
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
                                  labelText: translate('signup.password_label'),
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
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: register,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColorLight,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      minimumSize: const Size(175, 50),
                                    ),
                                    child: Text(
                                      translate('signup.signup_button'),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.white,
                                        fontFamily: "Lato",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
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