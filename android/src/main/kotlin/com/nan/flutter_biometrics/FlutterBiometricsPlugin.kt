package com.nan.flutter_biometrics

import android.util.Log
import android.content.Context
import androidx.annotation.NonNull
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** FlutterBiometricsPlugin */
class FlutterBiometricsPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private var activity: FragmentActivity? = null
  private var context: Context? = null

  private lateinit var biometricPrompt : BiometricPrompt
  private lateinit var biometricManager: BiometricManager

  private var title = ""
  private var description = ""
  private var cancelTitle = ""

  companion object {
    private const val CHANNEL = "nan.native_biometrics"
    private const val VERIFY = "verify"
    private const val TAG = "FlutterBiometrics"

    private const val SUCCESS = "success"
    private const val ERROR = "authFailed"
    private const val NOT_AVAILABLE = "notAvailable"
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    biometricManager = BiometricManager.from(context!!) // Setup Biometric Manager
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL)
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == VERIFY) {
      if (isBiometricFeatureAvailable()) {
        title = call.argument("title")!!
        description = call.argument("description")!!
        cancelTitle = call.argument("cancel")!!
        performBiometricsLogin(result)
      } else {
        result.success( NOT_AVAILABLE )
      }

    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    Log.d(TAG, "onDetachedFromEngine")
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    Log.d(TAG, "onAttachedToActivity")
    activity = binding.activity as FragmentActivity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    Log.d(TAG, "onDetachedFromActivityForConfigChanges")
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    Log.d(TAG, "onReattachedToActivityForConfigChanges")
    activity = binding.activity as FragmentActivity
  }

  override fun onDetachedFromActivity() {
    Log.d(TAG, "onDetachedFromActivity")
    activity = null
  }

  private fun isBiometricFeatureAvailable(): Boolean {
    return biometricManager.canAuthenticate() == BiometricManager.BIOMETRIC_SUCCESS
  }

  private fun buildBiometricPrompt(): BiometricPrompt.PromptInfo {
   return BiometricPrompt.PromptInfo.Builder()
            .setTitle(title)
            .setDescription(description)
            .setNegativeButtonText(cancelTitle)
            .setConfirmationRequired(false) // 顯示確認按鈕
            .build()
  }

  private fun performBiometricsLogin(@NonNull result: Result) {
    val executor = ContextCompat.getMainExecutor(context)
    biometricPrompt = BiometricPrompt(activity!!, executor, object: BiometricPrompt.AuthenticationCallback(){
      override fun onAuthenticationSucceeded(authResult: BiometricPrompt.AuthenticationResult) {
        result.success( SUCCESS )
      }

      override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
        result.success( ERROR )
      }
    })

    biometricPrompt.authenticate(buildBiometricPrompt())
  }
}
