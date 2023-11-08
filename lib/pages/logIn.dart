import 'package:flutter/material.dart';
import 'package:messenger/components/my_button.dart';
import 'package:messenger/components/my_text_field.dart';
import 'package:messenger/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  final void Function()? onTap;

  const LogInPage({super.key, required this.onTap});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    //get the auth service

    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithaEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50.0),
                //logo
                const Hero(
                  tag: 'logo',
                  child: Icon(
                    Icons.message,
                    size: 100.0,
                  ),
                ),
                const SizedBox(height: 50.0),
                //welcome back message
                const Text(
                  'Welcome Back you\'ve been missed!!!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25.0),
                MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),
                const SizedBox(height: 10.0),
                //passwordText field
                MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true),

                const SizedBox(height: 25.0),
                //sign in button
                MyButton(onTap: signIn, text: 'Sign In'),

                const SizedBox(height: 50.0),

                //not a member? register now

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a Member?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
