import Flutter
import LocalAuthentication

typealias BiometricsReply = (Bool, Error?) -> Void

public class SwiftBiometrics {
    // User authentication with biometry, Apple Watch, or the device passcode.
    let authPolicy = LAPolicy.deviceOwnerAuthentication
    
    func biometricsLogin(withArguments args: Dictionary<String, String>, result: @escaping FlutterResult) {
          let cancelTitle = args["cancelTitle"] as! String
          let fallbackTitle = args["fallbackTitle"] as! String
          let authReason = args["authReason"] as! String

          let context = LAContext()
          var error: NSError?
          
          // & (Ampersand Sign) - inout parameter
          // The inout parameter has the value passed to the function, modified by the function,
          // and passed back to it to replace the original value.
          if context.canEvaluatePolicy(authPolicy, error: &error) {
              context.localizedCancelTitle = cancelTitle
              context.localizedFallbackTitle = fallbackTitle
              context.localizedReason = authReason
              biometricsVerify(context,reason: authReason, result: result)
          }
          else { result( BiometricsResult.userCancel.rawValue ) }
      }
      
      func biometricsVerify(_ context: LAContext, reason: String, result: @escaping FlutterResult) {
          context.evaluatePolicy(authPolicy, localizedReason: reason) { ( authResult, error ) in
              if ( authResult ) { result( BiometricsResult.success.rawValue ) }
              else { self.handleBiometricsError(error: error, result: result) }
          }
      }
      
      func handleBiometricsError(error: Error?, result: @escaping FlutterResult) {
          guard let error = error as NSError? else { return }
          
          let errorCode = Int32(error.code)
          switch errorCode {
              case kLAErrorAppCancel: result( BiometricsResult.appCancel.rawValue )
              case kLAErrorSystemCancel: result( BiometricsResult.systemCancel.rawValue )
              case kLAErrorUserCancel: result( BiometricsResult.userCancel.rawValue )
              case kLAErrorBiometryDisconnected: result( BiometricsResult.disconnected.rawValue )
              case kLAErrorBiometryLockout: result( BiometricsResult.lockOut.rawValue )
              case kLAErrorBiometryNotAvailable: result( BiometricsResult.notAvailable.rawValue )
              case kLAErrorBiometryNotPaired: result( BiometricsResult.notPaired.rawValue )
              case kLAErrorAuthenticationFailed: result( BiometricsResult.authFailed.rawValue )
              case kLAErrorInvalidContext: result( BiometricsResult.invalidContext.rawValue )
              case kLAErrorInvalidDimensions: result( BiometricsResult.invalidDimension.rawValue )
              case kLAErrorNotInteractive: result( BiometricsResult.notInteractive.rawValue )
              case kLAErrorPasscodeNotSet: result( BiometricsResult.passcodeNotSet.rawValue )
              case kLAErrorUserFallback: result( BiometricsResult.userFallback.rawValue )
              case kLAErrorWatchNotAvailable: result( BiometricsResult.watchNotAvailable.rawValue )
              default: result( BiometricsResult.unknownError.rawValue )
          }
    }
}
