//
//  BiometricAuth.swift
//  medi buddy test
//
//  Created by Sachin Gunawardena on 2025-04-23.
//

import Foundation
import LocalAuthentication

class BiometricAuth: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access your account"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                    } else {
                        self.errorMessage = authError?.localizedDescription ?? "Authentication failed"
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.errorMessage = error?.localizedDescription ?? "Biometric authentication not available"
            }
        }
    }
}
