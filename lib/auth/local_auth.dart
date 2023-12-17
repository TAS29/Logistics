import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  final LocalAuthentication _localAuth = LocalAuthentication();

//Check if biometric auth is available
  Future<bool> hasBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

//Check type of biometric auth available (Eg - Face ID, fingerprint)
  Future<void> checkBiometricType() async {
    final availableBiometrics = await _localAuth.getAvailableBiometrics();
    print('Available biometrics: $availableBiometrics');
  }

  Future<bool> authenticate() async {
    final hasBiometric = await hasBiometrics();

    if (hasBiometric) {
      return await _localAuth.authenticate(
        localizedReason: "Scan fingerprint to authenticate",
        options: const AuthenticationOptions(
          //Shows error dialog for system-related issues
          useErrorDialogs: true,
          //If true, auth dialog is show when app open from background
          stickyAuth: true,
          //Prevent non-biometric auth like such as pin, passcode.
          biometricOnly: true,
        ),
      );
    } else {
      return false;
    }
  }
}
