import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class LocalAuthPlugin {
  static final LocalAuthentication auth = LocalAuthentication();

  static availableBiometrics() async {
    final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }

    if (availableBiometrics.contains(BiometricType.strong) || availableBiometrics.contains(BiometricType.face)) {
      // Specific types of biometrics are available.
      // Use checks like this with caution!
    }
  }

  static Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  static Future<(bool, String)> authenticate({ bool biometricOnly = false}) async {

    try {

      final bool didAuthenticated = await auth.authenticate(
        localizedReason: 'Por favor autentícate para continuar',
        options: const AuthenticationOptions(
          biometricOnly: true // false podemos colocar el PIN
        ),
      );

      return (didAuthenticated, didAuthenticated ? 'Biometric authenticated' : 'Biometric not authenticated');

    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) return (false, 'Biometric not enrolled');
      if (e.code == auth_error.lockedOut) return (false, 'Biometric locked out');
      if (e.code == auth_error.notAvailable) return (false, 'Biometric not available');
      if (e.code == auth_error.passcodeNotSet) return (false, 'Passcode not set');
      if (e.code == auth_error.permanentlyLockedOut) return (false, 'Biometric permanently locked out');

      return (false, e.toString());
    }

  }

}