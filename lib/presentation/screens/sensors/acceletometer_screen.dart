import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class AccelerometerScreen extends ConsumerWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final accelermeter$ = ref.watch( accelerometerUserProvider );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acceletometer'),
      ),
      body: Center(
        child: accelermeter$.when(
          data: (value) => Text(
            value.toString(),
            style: const TextStyle(fontSize: 30),
          ),
          error: (error, stackTrace) => Text('$error'), 
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}