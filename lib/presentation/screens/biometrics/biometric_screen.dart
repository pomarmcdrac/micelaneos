import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class BiometricScreen extends ConsumerWidget {

  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final canCheckBiometrics = ref.watch(canCheckBiometricsProvider);
    final localAuthState = ref.watch(localAuthProvider);

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
                ref.read(localAuthProvider.notifier).authenticateUser();
              }, 
              child: const Text('Authenticate'),
            ),
            canCheckBiometrics.when(
              data: (canCheck) => Text('Can check biometrics: $canCheck'), 
              error: (error, _ ) => Text('Error: $error'), 
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(height: 40,),
            const Text(
              'Estado del biométrico',
              style: TextStyle(fontSize: 30),
            ),
            const Text(
              'Estado XXXXXX',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Status: $localAuthState', 
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}