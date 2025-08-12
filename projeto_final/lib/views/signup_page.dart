import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
            debugPrint("Image picker error: $error");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Failed to access gallery"),
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
      debugPrint("Unexpected error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("An unexpected error occurred"),
          backgroundColor: AppColors.red,
        ),
      );
    }
  }

  Future<void> register() async {
    if (_name.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name is required'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_email.text.isEmpty || !_email.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_password.text.isEmpty || _password.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be at least 6 characters'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Creating account...'),
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
              content: const Text('Image is too large, please select a smaller one'),
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
        builder:
            (context) => AlertDialog(
              title: const Text('Registration Complete!'),
              content: const Text('Your account has been created successfully'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (FirebaseAuth.instance.currentUser != null) {
                      Navigator.pushReplacementNamed(context, "/homePage");
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();

      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password is too weak';
          break;
        case 'email-already-in-use':
          errorMessage = 'Email already in use';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format';
          break;
        default:
          errorMessage = 'Registration failed: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: AppColors.red),
      );
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Image.asset(
                        AppImages.logoSplash,
                        height: 240 * 0.8,
                        width: 290 * 0.8,
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              _selectedImage != null
                                  ? MemoryImage(
                                    base64Decode(
                                      base64Encode(
                                        _selectedImage!.readAsBytesSync(),
                                      ), 
                                    ),
                                  )
                                  : null,
                          child:
                              _selectedImage == null
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
                                  labelText: "Name",
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
                                  labelText: "E-mail",
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
                                  labelText: "Password",
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
                                      backgroundColor:
                                          AppColors.primaryColorLight,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      minimumSize: const Size(175, 50),
                                    ),
                                    child: Text(
                                      "Sign Up",
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
