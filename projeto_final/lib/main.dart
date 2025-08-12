import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:projeto_final/firebase_options.dart';
import 'package:projeto_final/views/home_page.dart';
import 'package:projeto_final/views/intro_pages.dart';
import 'package:projeto_final/views/login_page.dart';
import 'package:projeto_final/views/profile_page.dart';
import 'package:projeto_final/views/signup_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RICK AND MORTY API',
      initialRoute: "/homePage",
      routes: {
        "/homePage": (context) => HomePage(),
        "/loginPage" : (context) => LoginPage(),
        "/signupPage" : (context) => SignupPage(),
        "/introPages" : (context) => IntroPages(),
        "/profilePage" : (context) => ProfilePage(),
      },
      theme: ThemeData(
        fontFamily: "Lato"
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
