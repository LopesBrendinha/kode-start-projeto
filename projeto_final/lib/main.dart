import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:projeto_final/controllers/theme_controller.dart';
import 'package:projeto_final/firebase_options.dart';
import 'package:projeto_final/theme/app_colors.dart';
import 'package:projeto_final/views/home_page.dart';
import 'package:projeto_final/views/intro_pages.dart';
import 'package:projeto_final/views/login_page.dart';
import 'package:projeto_final/views/profile_page.dart';
import 'package:projeto_final/views/signup_page.dart';
import 'package:projeto_final/views/splash_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'pt_BR', 
    supportedLocales: ['pt_BR', 'en_US'], 
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    LocalizedApp(
      delegate,
      ChangeNotifierProvider(
        create: (_) => ThemeController(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final localizationDelegate = LocalizedApp.of(context).delegate;

    return MaterialApp(
      title: 'RICK AND MORTY API',
      initialRoute: "/splashsPage", 
      routes: {
        "/homePage": (context) => HomePage(),
        "/loginPage": (context) => LoginPage(),
        "/signupPage": (context) => SignupPage(),
        "/introPages": (context) => IntroPages(),
        "/profilePage": (context) => ProfilePage(),
        "/splashPage": (context) => SplashPage(),
      },
      themeMode: themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primaryColorLight,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryColorDark,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        localizationDelegate
      ],
      supportedLocales: localizationDelegate.supportedLocales,
      locale: localizationDelegate.currentLocale,
    );
  }
}