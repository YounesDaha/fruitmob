import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    final login = _loginController.text.trim();
    final password = _passwordController.text;

    if (login.isEmpty || password.isEmpty) {
      _showSnackbar('Les champs ne peuvent pas être vides.');
      return;
    }

    try {
      // Connexion avec Firebase
      UserCredential user = await _auth.signInWithEmailAndPassword(
        email: login,
        password: password,
      );

      _showSnackbar('Connexion réussie : ${user.user?.email}');
      // Redirection vers la page d'accueil
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      _showSnackbar('Erreur de connexion : ${_getErrorMessage(e)}');
    }
  }

  String _getErrorMessage(dynamic error) {
    // Vous pouvez personnaliser les messages d'erreur ici
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'Utilisateur non trouvé.';
        case 'wrong-password':
          return 'Mot de passe incorrect.';
        case 'invalid-email':
          return 'Email invalide.';
        default:
          return error.message ?? 'Erreur inconnue.';
      }
    }
    return error.toString();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application de Vêtements'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Se connecter'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text("Vous n'avez pas de compte ? S'inscrire"),
            ),
          ],
        ),
      ),
    );
  }
}
