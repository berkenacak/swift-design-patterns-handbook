/*
 ----------------------------------------------------------------------------
 PATTERN: Decorator
 CATEGORY: Structural
 
 PROBLEM IT SOLVES:
 Attaches additional responsibilities to an object dynamically.
 Decorators provide a flexible alternative to subclassing for
 extending functionality.
 
 SCENARIO:
 Adding "Network Logging" and "Auth Headers" to a base Network Service
 without changing the original class code.
 ----------------------------------------------------------------------------
 */

import Foundation

// MARK: - 1. Component Protocol
fileprivate protocol NetworkService {
    func request(url: URL)
}

// MARK: - 2. Concrete Component
fileprivate final class DefaultNetworkService: NetworkService {
    func request(url: URL) {
        print("🌐 Executing basic HTTP Request to: \(url.absoluteString)")
    }
}

// MARK: - 3. Base Decorator
fileprivate class NetworkDecorator: NetworkService {
    fileprivate let decoratee: NetworkService
    
    init(decoratee: NetworkService) {
        self.decoratee = decoratee
    }
    
    func request(url: URL) {
        decoratee.request(url: url)
    }
}

// MARK: - 4. Concrete Decorators

// Decorator 1: Adds Logging
fileprivate final class LoggingDecorator: NetworkDecorator {
    
    override func request(url: URL) {
        print("📝 [LOG] Request started at \(Date())")
        super.request(url: url)
        print("✅ [LOG] Request finished")
    }
}

// Decorator 2: Adds Auth Headers
fileprivate final class AuthDecorator: NetworkDecorator {
    override func request(url: URL) {
        print("🔐 [AUTH] Injecting Bearer Token into headers...")
        super.request(url: url)
    }
}

/*
 // ==========================================
 // USAGE EXAMPLE
 // ==========================================
 
 let url = URL(string: "https://api.example.com/data")!
 
 // 1. Base Service
 let baseService: NetworkService = DefaultNetworkService()
 
 // 2. Add Logging
 let serviceWithLogging = LoggingDecorator(decoratee: baseService)
 
 // 3. Add Auth (Wraps the LoggingDecorator which wraps the BaseService)
 let secureServiceWithLogging = AuthDecorator(decoratee: serviceWithLogging)
 
 // Now execute. It will perform Auth -> Logging -> Base Request
 secureServiceWithLogging.request(url: url)
 */
