/*
 ----------------------------------------------------------------------------
 PATTERN: Factory Method
 CATEGORY: Creational
 
 PROBLEM IT SOLVES:
 Defines an interface (Creator) for creating an object (Product), but lets
 subclasses or conforming types decide which class to instantiate.
 
 DIFFERENCE FROM ABSTRACT FACTORY:
 Factory Method creates ONE product. Abstract Factory creates families of
 related products.
 
 SCENARIO:
 Profile Module Navigation. Generating the correct single View Controller
 for "Guest" vs "Member" users via a polymorphic protocol.
 ----------------------------------------------------------------------------
 */

import UIKit

// MARK: - 1. The Creator Interface
// (This was mislabeled before. It's the 'Creator', not Abstract Factory)
protocol ProfileModuleFactory {
    // The "Factory Method" itself
    func makeProfileScreen() -> UIViewController
}

// MARK: - 2. Concrete Creator A (For Guests)
struct GuestProfileFactory: ProfileModuleFactory {
    func makeProfileScreen() -> UIViewController {
        let vc = UIViewController() // In real app: GuestSignupViewController()
        vc.title = "Join Us"
        vc.view.backgroundColor = .systemGray6
        
        // Setup specific logic for guests
        print("🔧 Configuring Guest Screen...")
        return vc
    }
}

// MARK: - 3. Concrete Creator B (For Members)
struct MemberProfileFactory: ProfileModuleFactory {
    let currentUser: String
    
    func makeProfileScreen() -> UIViewController {
        let vc = UIViewController() // In real app: UserDashboardViewController()
        vc.title = "Hello, \(currentUser)"
        vc.view.backgroundColor = .systemBlue
        
        // Setup specific logic for members
        print("🔧 Configuring Member Screen for \(currentUser)...")
        return vc
    }
}

/*
 // ==========================================
 // USAGE EXAMPLE (e.g., inside AppCoordinator.swift)
 // ==========================================
 
 class ProfileCoordinator {
    let navigationController: UINavigationController
    
    // We rely on the abstraction (Creator), not concrete structs.
    let factory: ProfileModuleFactory
 
    init(nav: UINavigationController, factory: ProfileModuleFactory) {
        self.navigationController = nav
        self.factory = factory
    }
 
    func start() {
        // Polymorphism in action:
        // We don't know if it's a Guest or Member screen, and we don't care.
        let vc = factory.makeProfileScreen()
        navigationController.pushViewController(vc, animated: true)
    }
 }
 
 // --- Entry Point (SceneDelegate) ---
 
 func showProfile() {
    let isUserLoggedIn = true
    
    // Select the correct factory implementation
    let selectedFactory: ProfileModuleFactory = isUserLoggedIn
        ? MemberProfileFactory(currentUser: "Berke")
        : GuestProfileFactory()
 
    let coordinator = ProfileCoordinator(nav: navigationController, factory: selectedFactory)
    coordinator.start()
 }
 */
