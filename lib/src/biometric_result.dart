enum BiometricResult {
  success,

  // Cancellation
  appCancel,
  systemCancel,
  userCancel,

  // Biometry Failure
  disconnected,
  notPaired,
  lockOut,
  notAvailable,
  notEnrolled,

  // Other Failure
  authFailed,
  invalidContext,
  invalidDimension,
  notInteractive,
  passcodeNotSet,
  userFallback,
  watchNotAvailable,
  unknownError,
}

extension BiometricResultExtension on String {
  BiometricResult get code {
    switch (this) {
      case "success":
        return BiometricResult.success;
      case "appCancel":
        return BiometricResult.appCancel;
      case "systemCancel":
        return BiometricResult.systemCancel;
      case "userCancel":
        return BiometricResult.userCancel;
      case "disconnected":
        return BiometricResult.disconnected;
      case "notPaired":
        return BiometricResult.notPaired;
      case "lockOut":
        return BiometricResult.lockOut;
      case "notAvailable":
        return BiometricResult.notAvailable;
      case "notEnrolled":
        return BiometricResult.notEnrolled;
      case "authFailed":
        return BiometricResult.authFailed;
      case "invalidContext":
        return BiometricResult.invalidContext;
      case "invalidDimension":
        return BiometricResult.invalidDimension;
      case "notInteractive":
        return BiometricResult.notInteractive;
      case "passcodeNotSet":
        return BiometricResult.passcodeNotSet;
      case "userFallback":
        return BiometricResult.userFallback;
      case "watchNotAvailable":
        return BiometricResult.watchNotAvailable;
      case "unknownError":
        return BiometricResult.unknownError;
      default:
        return BiometricResult.unknownError;
    }
  }
}
