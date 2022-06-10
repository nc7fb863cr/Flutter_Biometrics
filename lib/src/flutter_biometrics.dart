import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_biometrics/src/configs.dart';
import 'package:flutter_biometrics/src/constants.dart';
import 'package:flutter_biometrics/src/biometric_result.dart';

class FlutterBiometrics {
  static Future<BiometricResult> verify({@required ConfigInterface config}) async {
    if (config == null) throw Exception("Biometric config is required!");

    if (config is AndroidBiometricConfig && !Platform.isAndroid)
      throw Exception("AndroidBiometricConfig doesn\'t work on your platform!");

    if (config is IOSBiometricConfig && !Platform.isIOS)
      throw Exception("IOSBiometricConfig doesn\'t work on your platform!");

    final arguments = config.toMap();
    final String result = await Constants.channel.invokeMethod(Constants.verify, arguments);
    return result.code;
  }
}
