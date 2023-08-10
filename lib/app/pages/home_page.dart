import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kaike Barbearia", style: TextStyle(fontSize: 25),),
        toolbarHeight: 80,
      ),
      body: const Center(
        child: Text("Minha barbearia"),
      ),
    );
  }
}
