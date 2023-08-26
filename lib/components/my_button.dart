import 'package:flutter/material.dart';

class MyBtn extends StatelessWidget {
  final void Function()? onTap;
  final LinearGradient? gradient;
  final String text;
  const MyBtn({super.key, required this.onTap, required this.text, this.gradient});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width/3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: gradient,
        ),
        child: Center(
          child: Text(text, style: const TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
