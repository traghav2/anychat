// ignore_for_file: use_build_context_synchronously

import 'package:anychat/components/my_button.dart';
import 'package:anychat/components/my_text_field.dart';
import 'package:anychat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    //getting the auth service:
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.red,
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
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 30),
              Image.asset("assets/images/logo.png", height: 74),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              const Text(
                "Login Page",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
                color: Colors.white,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
                color: Colors.white,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
              MyBtn(
                  onTap: () {
                    signIn();
                  },
                  text: "Login",
                  gradient: const LinearGradient(
                    colors: [Color(0xfff9b121), Color(0xffea453a)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )),
              SizedBox(height: MediaQuery.of(context).size.height / 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Not a Member? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register Now!",
                      style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
