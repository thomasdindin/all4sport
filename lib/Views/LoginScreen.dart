import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:all4sport/Services/api_services.dart';
import 'package:crypto/crypto.dart';

import 'HomeScreen.dart';

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String message = '';

  Future<void> handleLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final apiService = ApiService();
        var output = sha256.convert(utf8.encode(password)).toString();
        bool success = await apiService.postUser(email, output);

        if (success) {
          setState(() {
            message = 'Login successful';
          });

          // Delay redirection for 1 second
          await Future.delayed(const Duration(seconds: 1));

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          setState(() {
            message = 'Login failed';
          });
        }
      } catch (e) {
        print('Error during login: $e');
        setState(() {
          message = 'Internal Error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                // You can add more complex email validation if needed
                return null;
              },
              onSaved: (value) {
                email = value!;
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                // You can add more complex password validation if needed
                return null;
              },
              onSaved: (value) {
                password = value!;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleLogin,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

