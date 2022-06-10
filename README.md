# Flutter Biometrics Plugin

## Introduction

This plugin makes it easy for flutter app to perform biometric validation function that is otherwise only accessible on native platform like iOS and Android.

## Supported Platforms

- Support iOS (11+).

- Support Android (minSdkVersion 16).

## Add Dependency To Flutter

- Since the plugin has yet been published to [pub.dev](https://pub.dev/), add github repository to your `pubspec.yaml` as dependency.

  - url: Github Repo Url

  - ref: add branch name (**main**) or commit id (**fc9be3b**) 

  ```
  dependencies:
  ...
  flutter:
    sdk: flutter
  
  native_camera:
    git:
      url: https://github.com/nc7fb863cr/Flutter_Biometrics
      ref: <ref>
  ...
  ```

## IOS Installation

- This plugin requires iOS 11.0 or higher.

- Add the following key to **Info.plist**:

  * `NSFaceIDUsageDescription` - Describe why this app needs permission for Face ID.

    ```
    <key>NSFaceIDUsageDescription</key>
    <string>This app needs your permission to access Face ID.</string>
    ```

## Android Installation

- Enter `android/app/src/main/your_project_name/MainActivity.kt or MainActivity.java`.

- Change `MainActivity` to extend `FlutterFragmentActivity` instead of `FlutterActivity`.

  - Kotlin

    ```
    import io.flutter.embedding.android.FlutterFragmentActivity

    class MainActivity: FlutterFragmentActivity() {
      ...
    }
    ```

  - Java

    ```
    import io.flutter.embedding.android.FlutterFragmentActivity;

    class MainActivity extends FlutterFragmentActivity {
      ...
    }
    ```

## How To Use

- Configure Biometric Config For Your Platform

  - AndroidBiometricConfig

    ```
    AndroidBiometricConfig config = AndroidBiometricConfig(
      title: "Biometrics Validation",
      description: "Validate Your Identity With Biometrics",
      cancelTitle: "Cancel",
    );
    ```

  - IOSBiometricConfig

    ```
    IOSBiometricConfig config = IOSBiometricConfig(
      fallbackTitle: "Login With Account",
      cancelTitle: "Cancel Login",
      authReason: "Login With Account or Cancel Login",
    );
    ```

- Trigger Native Biometric Validation With Config

  ```
  // returns an enum of BiometricResult
  final BiometricResult result = await FlutterBiometrics.verify(config);
  ```

- The `BiometricResult` represents different validation status as below:

  - `success`: Validation success
  
  - `appCancel`: The app canceled authentication.
  
  - `systemCancel`: The system canceled authentication.
  
  - `userCancel`: The user tapped the cancel button in the authentication dialog.

  - `disconnected`: The device supports biometry only using a removable accessory, but the paired accessory isn’t connected.

  - `notPaired`: The device supports biometry only using a removable accessory, but no accessory is paired.

  - `lockOut`: Biometry is locked because there were too many failed attempts.
  
  - `notAvailable`: Biometry is not available on the device.
  
  - `notEnrolled`: The user has no enrolled biometric identities.

  - `authFailed`: The user failed to provide valid credentials.
  
  - `invalidContext`: The context was previously invalidated.

  - `invalidDimension`: Invalid Dimension
  
  - `notInteractive`: Displaying the required authentication user interface is forbidden.
  
  - `passcodeNotSet`: A passcode isn’t set on the device.
  
  - `userFallback`: The user tapped the fallback button in the authentication dialog, but no fallback is available for the authentication policy.

  - `watchNotAvailable`:An attempt to authenticate with Apple Watch failed.
  
  - `unknownError`: Unknown error.

## Example

- [See Example](example/README.md)

## Reference

- [salkuadrat - BiometricX](https://github.com/salkuadrat/BiometricX)

- [Swift - Local Authentication](https://medium.com/jeremy-xue-s-blog/swift-%E8%AA%AA%E8%AA%AA-localauthentication-lacontext-fb6c8c75b27a)