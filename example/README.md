# Flutter Biometrics Example

- main.dart

```
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_biometrics/flutter_biometrics.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _verified = false;
  bool _success = false;

  void verify() async {
    final iosConfig = IOSBiometricConfig(fallbackTitle: "使用帳號密碼登入", cancelTitle: "取消登入", authReason: "使用帳號密碼登入或取消登入");
    final androidConfig = AndroidBiometricConfig(title: "身份驗證", description: "請使用生物辨識驗證身份", cancelTitle: "取消");
    final config = Platform.isIOS ? iosConfig : androidConfig;

    final result = await FlutterBiometrics.verify(config: config);
    setState(() {
      _verified = true;
      _success = result == BiometricResult.success;
    });
  }

  Widget _buildButton() {
    return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.teal[300],
          padding: EdgeInsets.all(12.0),
        ),
        child: Text(
          "Login With Native Biometrics",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        onPressed: verify);
  }

  Widget _buildResult() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Text(
        _verified
            ? _success
                ? "Success"
                : "Error"
            : "Not Yet Verified",
        style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: _verified
                ? _success
                    ? Colors.teal
                    : Colors.red
                : Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Native Biometrics Demo"), centerTitle: true),
      body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_buildButton(), _buildResult()],
          )),
    );
  }
}
```
