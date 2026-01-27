/*
 ----------------------------------------------------------------------------
 PATTERN: Abstract Factory
 CATEGORY: Creational
 
 PROBLEM IT SOLVES:
 Provides an interface for creating families of related or dependent objects
 without specifying their concrete classes. Ensures that the created objects
 (e.g., Network Service + Analytics Service) work together compatibly.
 
 KEY DIFFERENCE:
 Factory Method -> Creates ONE product.
 Abstract Factory -> Creates a FAMILY of products.
 
 SCENARIO:
 App Environment Management. Switching between "Production" (Real APIs) and
 "Staging/Test" (Mock APIs) without changing the business logic code.
 ----------------------------------------------------------------------------
 */

import Foundation

// MARK: - Abstract Products (Interfaces)
fileprivate protocol NetworkService {
    func fetch() -> String
}

fileprivate protocol AnalyticsService {
    func log()
}

// MARK: - Abstract Factory Interface
fileprivate protocol EnvironmentFactory {
    var networkService: NetworkService { get }
    var analyticsService: AnalyticsService { get }
}

// MARK: - Concrete Family 1: Production (Real World)
fileprivate struct RealNetwork: NetworkService {
    func fetch() -> String { return "Real Data from API" }
}

fileprivate struct RealAnalytics: AnalyticsService {
    func log() { print("Logging to Firebase...") }
}

fileprivate struct ProductionEnvironment: EnvironmentFactory {
    let networkService: NetworkService = RealNetwork()
    let analyticsService: AnalyticsService = RealAnalytics()
}

// MARK: - Concrete Family 2: Testing (Mock World)
fileprivate struct MockNetwork: NetworkService {
    func fetch() -> String { return "{\"mock\": true}" }
}

fileprivate struct MockAnalytics: AnalyticsService {
    func log() { print("Logging to Console (Debug)...") }
}

fileprivate struct TestEnvironment: EnvironmentFactory {
    let networkService: NetworkService = MockNetwork()
    let analyticsService: AnalyticsService = MockAnalytics()
}

/*
 // ==========================================
 // USAGE EXAMPLE (e.g., inside AppContainer or DependencyInjection)
 // ==========================================
 
 class AppContainer {
    let factory: EnvironmentFactory
    
    init(isDebug: Bool) {
        // Decide the entire family of services once at startup
        self.factory = isDebug ? TestEnvironment() : ProductionEnvironment()
    }
    
    func start() {
        // The rest of the app doesn't know if services are real or mock.
        print(factory.networkService.fetch())
        factory.analyticsService.log()
    }
 }
 
 // Usage:
 // let app = AppContainer(isDebug: true)
 // app.start()
 // Output: "{"mock": true}" and "Logging to Console (Debug)..."
 */
