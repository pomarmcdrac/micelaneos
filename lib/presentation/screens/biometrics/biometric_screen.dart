import 'package:flutter/material.dart';

class BiometricScreen extends StatelessWidget {

  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                
              }, 
              child: const Text('Authenticate'),
            ),
            //TODO Feedback del proceso
            const SizedBox(height: 40,),
            const Text(
              'Estado del biométrico',
              style: TextStyle(fontSize: 30),
            ),
            const Text(
              'Estado XXXXXX',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}