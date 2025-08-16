import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/routes.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> failedPassword = [
    'I wonder are you hacking or just being stupid 😂😂😂!',
    'Pal! Are you suppose to be here? 🤨',
    'Access denied! Did you just mash your keyboard? ⌨️🙈',
    'Wrong password. Even my grandma could do better! 👵💻',
    'Nope. Not even close, secret agent. 🕵️‍♂️🚫',
    'Are you lost? This isn’t Google. 🗺️🔍',
    'Nice try, but the force is not with you. ✨🖖',
    'If at first you don’t succeed, try a different password. 🔄🔑',
    'That’s not the password, but it’s adorable you tried. 🥲💡',
    'Error 404: Password skills not found. 🛑🧑‍💻',
    'You shall not pass! 🧙‍♂️🚧',
    'This is not the password you’re looking for. 👋🪄',
  ];

  final List<String> areYouSure = [
    'Are you sure you’re supposed to be here, secret agent? 🕵️‍♂️',
    'Warning: Unauthorized access may result in spontaneous dance battles! 💃🕺',
    'This area is hotter than your browser history. Proceed with caution! 🔥😏',
    'You look suspiciously cool for this restricted zone. Are you undercover? 😎🚫',
    'Credentials, please! Or do you just like living on the edge? 🏄‍♂️🔒',
  ];

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == '1z2e1h40') {
        Provider.of<AuthController>(context, listen: false).login();
        context.goNamed(RouteConstants.admin);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  failedPassword[Random().nextInt(failedPassword.length)])),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verification')),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(areYouSure[Random().nextInt(areYouSure.length)]),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Enter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
