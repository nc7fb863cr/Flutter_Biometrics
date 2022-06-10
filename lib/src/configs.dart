import 'package:flutter/material.dart';

abstract class ConfigInterface {
  Map<String, String> toMap();
}

class AndroidBiometricConfig implements ConfigInterface {
  AndroidBiometricConfig({@required this.title, @required this.description, @required this.cancelTitle})
      : assert(title != null && title.isNotEmpty),
        assert(description != null && description.isNotEmpty),
        assert(cancelTitle != null && cancelTitle.isNotEmpty);

  final String title;
  final String description;
  final String cancelTitle;

  @override
  Map<String, String> toMap() {
    return {
      "title": title,
      "description": description,
      "cancel": cancelTitle,
    };
  }
}

class IOSBiometricConfig implements ConfigInterface {
  IOSBiometricConfig({@required this.fallbackTitle, @required this.cancelTitle, @required this.authReason})
      : assert(fallbackTitle != null && fallbackTitle.isNotEmpty),
        assert(cancelTitle != null && cancelTitle.isNotEmpty),
        assert(authReason != null && authReason.isNotEmpty);

  final String fallbackTitle;
  final String cancelTitle;
  final String authReason;

  @override
  Map<String, String> toMap() {
    return {
      "fallbackTitle": fallbackTitle,
      "cancelTitle": cancelTitle,
      "authReason": authReason,
    };
  }
}
