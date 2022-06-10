//
//  BiometricsResult.swift
//  Runner
//
//  Created by Ricky Lee on 2022/6/9.
//

enum BiometricsResult: String {
    case success = "success"
    
    // Cancellation
    case appCancel = "appCancel"
    case systemCancel = "systemCancel"
    case userCancel = "userCancel"
    
    // Biometry Failure
    case disconnected = "disconnected"
    case notPaired = "notPaired"
    case lockOut = "lockOut"
    case notAvailable = "notAvailable"
    case notEnrolled = "notEnrolled"
    
    // Other Failure
    case authFailed = "authFailed"
    case invalidContext = "invalidContext"
    case invalidDimension = "invalidDimension"
    case notInteractive = "notInteractive"
    case passcodeNotSet = "passcodeNotSet"
    case userFallback = "userFallback"
    case watchNotAvailable = "watchNotAvailable"
    case unknownError = "unknownError"
}
