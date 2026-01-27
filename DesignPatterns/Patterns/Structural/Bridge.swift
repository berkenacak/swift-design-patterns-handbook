/*
 ----------------------------------------------------------------------------
 PATTERN: Bridge
 CATEGORY: Structural
 
 PROBLEM IT SOLVES:
 Decouples an abstraction from its implementation so that the two can vary
 independently. It prevents a "Cartesian product" of classes (class explosion).
 
 SCENARIO:
 Decoupling Alert Types (Abstraction) from Platform Implementations (Implementation).
 ----------------------------------------------------------------------------
 */

import Foundation

// MARK: - 1. Implementor (The Bridge Interface)
fileprivate protocol PlatformImplementation {
    func render(title: String)
}

// MARK: - 2. Concrete Implementors
fileprivate final class IOSImplementation: PlatformImplementation {
    func render(title: String) {
        print("📱 iOS: Displaying native UIAlertController with title: \(title)")
    }
}

fileprivate final class MacOSImplementation: PlatformImplementation {
    func render(title: String) {
        print("💻 macOS: Displaying native NSAlert with title: \(title)")
    }
}

// MARK: - 3. Abstraction
fileprivate class Alert {
    fileprivate let platform: PlatformImplementation
    
    init(platform: PlatformImplementation) {
        self.platform = platform
    }
    
    func show() {
        fatalError("This method should be overridden")
    }
}

// MARK: - 4. Refined Abstractions
fileprivate final class BasicAlert: Alert {
    private let title: String
    
    init(title: String, platform: PlatformImplementation) {
        self.title = title
        super.init(platform: platform)
    }
    
    override func show() {
        platform.render(title: title)
    }
}

fileprivate final class ActionAlert: Alert {
    private let title: String
    
    init(title: String, platform: PlatformImplementation) {
        self.title = title
        super.init(platform: platform)
    }
    
    override func show() {
        print("🔔 Action Required:")
        platform.render(title: title)
    }
}

/*
 // ==========================================
 // USAGE EXAMPLE
 // ==========================================
 
 // We can dynamically switch platforms without changing the Alert logic.
 let iosPlatform = IOSImplementation()
 let macPlatform = MacOSImplementation()
 
 // 1. Basic Alert on iOS
 let alert1 = BasicAlert(title: "Welcome", platform: iosPlatform)
 alert1.show()
 
 // 2. Action Alert on macOS
 let alert2 = ActionAlert(title: "Confirm Delete", platform: macPlatform)
 alert2.show()
 */
