/*
 ----------------------------------------------------------------------------
 PATTERN: Singleton
 CATEGORY: Creational
 
 PROBLEM IT SOLVES:
 Ensures a class has only one instance and provides a global point of access
 to it. It prevents multiple instances of a shared resource (like a database
 connection or auth session) from conflicting with each other.
 
 MODERN SWIFT NOTE:
 In Swift 6+, we use 'actor' instead of 'class' to ensure thread safety
 automatically, preventing Data Races without manual locking.
 
 SCENARIO:
 Authentication Manager. Storing and accessing the user's session token
 safely from any thread.
 ----------------------------------------------------------------------------
 */

import Foundation

// MARK: - Dependencies (Must be Sendable)
struct UserSession: Sendable {
    let token: String
    let userId: String
    let expiry: Date
}

// MARK: - The Singleton Actor
actor AuthManager {
    
    // 1. The unique shared instance (Global Access Point)
    static let shared = AuthManager()
    
    // 2. Private initializer prevents external instantiation
    private init() {}
    
    // 3. Protected State (Internal Data)
    private var currentSession: UserSession?
    
    // MARK: - Actions
    
    func saveSession(token: String, userId: String) {
        let newSession = UserSession(token: token, userId: userId, expiry: Date().addingTimeInterval(3600))
        self.currentSession = newSession
        print("✅ Session saved for user: \(userId)")
    }
    
    func getValidToken() -> String? {
        guard let session = currentSession, session.expiry > Date() else {
            return nil
        }
        return session.token
    }
    
    func logout() {
        currentSession = nil
        print("🚪 User logged out.")
    }
}

/*
 // ==========================================
 // USAGE EXAMPLE (e.g., inside LoginViewModel.swift)
 // ==========================================
 
 func handleLoginSuccess(apiResponse: [String: String]) async {
    let token = apiResponse["token"] ?? ""
    let uid = apiResponse["user_id"] ?? ""
    
    // We must use 'await' because actors enforce serial access (Thread Safety)
    await AuthManager.shared.saveSession(token: token, userId: uid)
 }
 
 func makeSecureCall() async {
    if let token = await AuthManager.shared.getValidToken() {
        print("Sending request with token: \(token)")
    } else {
        print("Token expired or not found. Redirecting to Login...")
    }
 }
 */
