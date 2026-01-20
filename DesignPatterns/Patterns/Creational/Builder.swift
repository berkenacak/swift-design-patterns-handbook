/*
 ----------------------------------------------------------------------------
 PATTERN: Builder
 CATEGORY: Creational
 
 PROBLEM IT SOLVES:
 Simplifies the construction of complex objects with many optional parameters.
 It avoids "Telescoping Constructors" (init methods with 10+ arguments) and
 provides a readable, fluent interface for object creation.
 
 SCENARIO:
 Analytics Event Creation. Each event (Purchase, Login, Error) requires
 different sets of parameters.
 ----------------------------------------------------------------------------
 */

import Foundation

// MARK: - The Builder Class
final class AnalyticsEventBuilder {
    
    private var eventName: String
    private var parameters: [String: Any] = [:]
    
    // Mandatory parameter enforced at start
    init(name: String) {
        self.eventName = name
    }
    
    // MARK: - Chaining Methods (Fluent Interface)
    
    func addParameter(key: String, value: Any) -> AnalyticsEventBuilder {
        self.parameters[key] = value
        return self
    }
    
    func setScreen(_ screenName: String) -> AnalyticsEventBuilder {
        self.parameters["screen_name"] = screenName
        return self
    }
    
    func setUserProperty(userId: String) -> AnalyticsEventBuilder {
        self.parameters["user_id"] = userId
        return self
    }
    
    // MARK: - Final Build / Execute
    
    func send() {
        // In a real app, this would call Firebase.logEvent or similar SDK
        print("🚀 [Analytics Sent] Event: '\(eventName)' | Params: \(parameters)")
    }
}

/*
 // ==========================================
 // USAGE EXAMPLE (e.g., inside ProductDetailViewModel.swift)
 // ==========================================
 
 func trackAddToCart(productId: String, price: Double) {
    
    // Instead of a massive init(...) call, we use readable chaining steps
    AnalyticsEventBuilder(name: "add_to_cart")
        .setScreen("ProductDetailView")
        .setUserProperty(userId: "user_98765")
        .addParameter(key: "product_id", value: productId)
        .addParameter(key: "price", value: price)
        .addParameter(key: "currency", value: "USD")
        .send()
 }
 */
