/*
 ----------------------------------------------------------------------------
 PATTERN: Facade
 CATEGORY: Structural
 
 PROBLEM IT SOLVES:
 Provides a simplified interface to a complex body of code (subsystems).
 It hides the complexity of multiple classes and provides a single entry point.
 
 SCENARIO:
 A "Data Manager" that orchestrates Networking, Persistence (CoreData),
 and Caching. The ViewModel shouldn't know HOW data is fetched/stored.
 ----------------------------------------------------------------------------
 */

import Foundation

// MARK: - Subsystem 1: Networking
fileprivate final class NetworkService {
    func fetchRemoteData(completion: @escaping () -> Void) {
        print("🌐 Fetching from API...")
        completion()
    }
}

// MARK: - Subsystem 2: Persistence (Database)
fileprivate final class DatabaseService {
    func saveToDisk() {
        print("💾 Saving to CoreData/Realm...")
    }
}

// MARK: - Subsystem 3: Caching
fileprivate final class CacheService {
    func updateMemoryCache() {
        print("🧠 Updating memory cache...")
    }
}

// MARK: - THE FACADE
// This class simplifies the interaction for the rest of the app.
fileprivate final class AppDataManager {
    private let network = NetworkService()
    private let database = DatabaseService()
    private let cache = CacheService()
    
    /// A single, simple method that hides all the complexity.
    func refreshDashboardData() {
        print("🚀 Facade: Starting dashboard refresh sequence...")
        
        network.fetchRemoteData { [weak self] in
            self?.database.saveToDisk()
            self?.cache.updateMemoryCache()
            print("✅ Facade: Dashboard data is ready for the UI.")
        }
    }
}

/*
 // ==========================================
 // USAGE EXAMPLE (e.g., inside HomeViewModel)
 // ==========================================
 
 class HomeViewModel {
    // The ViewModel only depends on the Facade, not 3 different services.
    private let dataManager = AppDataManager()
    
    func loadContent() {
        // Clean and simple. No need to know about networking or database logic.
        dataManager.refreshDashboardData()
    }
 }
 */
