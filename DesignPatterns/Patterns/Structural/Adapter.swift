/*
 ----------------------------------------------------------------------------
 PATTERN: Adapter
 CATEGORY: Structural
 
 PROBLEM IT SOLVES:
 Allows incompatible interfaces to work together. It acts as a bridge between
 two different interfaces, especially when integrating 3rd party libraries
 that you don't control.
 
 SCENARIO:
 Integrating a 3rd party Analytics SDK (Legacy/External) into our
 modern Clean Architecture based Tracking System.
 ----------------------------------------------------------------------------
 */

import Foundation

// MARK: - 1. Target (The interface our app uses)
protocol AnalyticsTracking {
    func track(eventName: String, params: [String: Any]?)
}

// MARK: - 2. Adaptee (The 3rd Party SDK we want to use)
// This is an external library. We cannot change its code.
final class ExternalAnalyticsSDK {
    func logEvent(name: String, data: [String: Any]) {
        print("SDK LOG: Event '\(name)' with data \(data)")
    }
}

// MARK: - 3. The Adapter
// It wraps the external SDK and converts our calls to its format.
final class ExternalAnalyticsAdapter: AnalyticsTracking {
    private let sdk: ExternalAnalyticsSDK
    
    init(sdk: ExternalAnalyticsSDK) {
        self.sdk = sdk
    }
    
    func track(eventName: String, params: [String: Any]?) {
        // Here we adapt the data:
        // Our app sends optional params, but SDK requires non-optional.
        let data = params ?? [:]
        
        // Convert our 'track' call to SDK's 'logEvent' call
        sdk.logEvent(name: eventName, data: data)
    }
}

/*
 // ==========================================
 // USAGE EXAMPLE (e.g., inside a ViewModel)
 // ==========================================
 
 class LoginViewModel {
    private let analytics: AnalyticsTracking
    
    // Dependency Injection: We work with the protocol, not the SDK.
    init(analytics: AnalyticsTracking) {
        self.analytics = analytics
    }
    
    func didTapLogin() {
        // Business code stays clean
        analytics.track(eventName: "login_button_tapped", params: ["method": "biometric"])
    }
 }
 
 // --- Initialization ---
 
 let externalSDK = ExternalAnalyticsSDK()
 let adapter = ExternalAnalyticsAdapter(sdk: externalSDK)
 
 let vm = LoginViewModel(analytics: adapter)
 vm.didTapLogin()
 */
