// ignore_for_file: use_build_context_synchronously

import 'package:anychat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            padding: EdgeInsets.all(20),
            backgroundColor: Colors.red,
            content: Text("Passwords didn't match!!")),
      );
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try{
      await authService.signUpWithEmailandPassword(emailController.text, passwordController.text);
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
                "Register Page",
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
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              MyTextField(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                obscureText: true,
                color: Colors.white,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
              MyBtn(
                  onTap: () {
                    signUp();
                  },
                  text: "Register",
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
                    "Already a Member? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login Here!",
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
