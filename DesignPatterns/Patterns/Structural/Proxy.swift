/*
 ----------------------------------------------------------------------------
 PATTERN: Proxy
 CATEGORY: Structural
 
 PROBLEM IT SOLVES:
 Provides a surrogate or placeholder for another object to control access
 to it. Used for lazy loading, access control, or logging.
 
 SCENARIO:
 A Secure Image Downloader. It checks user authentication and delays
 the heavy image loading until it's actually requested.
 ----------------------------------------------------------------------------
 */

import Foundation

// MARK: - 1. Subject Protocol
fileprivate protocol SecureImageDisplay {
    func display()
}

// MARK: - 2. Real Subject
// The actual class that does the heavy work. Consumes significant memory.
fileprivate final class HighResolutionImage: SecureImageDisplay {
    private let url: URL
    
    init(url: URL) {
        self.url = url
        self.loadFromDisk() // Heavy operation starts upon instantiation
    }
    
    private func loadFromDisk() {
        print("💾 Loading heavy image from disk: \(url.lastPathComponent)...")
    }
    
    func display() {
        print("🖼️ Displaying image on screen.")
    }
}

// MARK: - 3. Proxy
// Wraps the real object, controls access, and implements lazy loading.
fileprivate final class ImageProxy: SecureImageDisplay {
    private let url: URL
    private var realImage: HighResolutionImage? // Used for lazy loading
    private let userRole: String
    
    init(url: URL, userRole: String) {
        self.url = url
        self.userRole = userRole
    }
    
    func display() {
        // 1. Access Control
        guard userRole == "ADMIN" else {
            print("🚫 Error: You do not have permission to view this image.")
            return
        }
        
        // 2. Lazy Loading
        // Real object is only created when display() is actually called.
        if realImage == nil {
            realImage = HighResolutionImage(url: url)
        }
        
        realImage?.display()
    }
}

/*
 // ==========================================
 // USAGE EXAMPLE
 // ==========================================
 
 // Case A: Unauthorized user
 let proxy1 = ImageProxy(url: URL(string: "contract.png")!, userRole: "GUEST")
 proxy1.display() // Output: "🚫 Error..."
 
 // Case B: Admin access
 let proxy2 = ImageProxy(url: URL(string: "contract.png")!, userRole: "ADMIN")
 
 // Object is created, but disk loading hasn't started because display() isn't called yet.
 print("--- Calling display ---")
 proxy2.display() // Loads (loadFromDisk) and then displays.
 */
