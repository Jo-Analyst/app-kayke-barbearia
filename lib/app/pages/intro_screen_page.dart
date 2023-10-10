import 'dart:async';

import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void screen() {
    Navigator.of(context).pop();
  }

  // Método para navegar para a tela principal após alguns segundos
  void _navigateToHome() {
    Timer(const Duration(seconds: 2), () async {
      final confirmExit =
          await Navigator.of(context).pushReplacementNamed('/home');

      if (confirmExit == true) {
        screen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(0, 74, 173, 1),
      child: Center(
        child: Image.asset("assets/images/logo.jpg"),
      ),
    );
  }
}
