import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseService _auth = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            ElevatedButton(
              onPressed: _handleLogin,
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    final user = await _auth.signIn(
      _emailController.text,
      _passwordController.text,
    );
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}