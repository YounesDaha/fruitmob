import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_6/firebase_options.dart';
import 'package:flutter_application_6/screen/HomePage.dart';
import 'package:flutter_application_6/screen/LoginPage.dart';
import 'package:flutter_application_6/screen/RegisterPage.dart';
import 'package:flutter_application_6/screen/UserProfilePage.dart'; // Assurez-vous que ce chemin est correct

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application de fruit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const FruitListPage(),
        '/user': (context) => const UserProfilePage(),

      },
    );
  }
}

class HomePage {
  const HomePage();
}
