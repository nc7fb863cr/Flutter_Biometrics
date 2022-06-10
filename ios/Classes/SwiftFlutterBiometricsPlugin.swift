import Flutter

public class SwiftFlutterBiometricsPlugin: NSObject, FlutterPlugin {
  let biometrics = SwiftBiometrics()
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: Constants.channel, binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterBiometricsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == Constants.verify { 
        let args = call.arguments as! Dictionary<String, String>
        self.biometrics.biometricsLogin(withArguments: args, result: result)
    }
    
    else {
        result(FlutterMethodNotImplemented)
        return
    }
  }
}
