/*
 ----------------------------------------------------------------------------
 PATTERN: Flyweight
 CATEGORY: Structural
 
 PROBLEM IT SOLVES:
 Minimizes memory usage by sharing as much data as possible with similar objects.
 It is particularly useful when creating a large number of objects.
 
 SCENARIO:
 A Chat UI. Thousands of messages share the same User Profile data (Avatar, Name)
 to save memory.
 ----------------------------------------------------------------------------
 */

import UIKit

// MARK: - 1. Flyweight (Shared State)
// Stores heavy, constant data (Intrinsic State).
fileprivate final class UserProfileFlyweight {
    let username: String
    let avatar: UIImage
    
    init(username: String, avatar: UIImage) {
        self.username = username
        self.avatar = avatar
        print("🏗️ New Flyweight created for user: \(username)")
    }
}

// MARK: - 2. Flyweight Factory
// Manages and reuses flyweight objects.
fileprivate final class UserProfileFactory {
    private static var profiles: [String: UserProfileFlyweight] = [:]
    
    static func getProfile(username: String, avatar: UIImage) -> UserProfileFlyweight {
        if let existing = profiles[username] {
            return existing
        }
        
        let newProfile = UserProfileFlyweight(username: username, avatar: avatar)
        profiles[username] = newProfile
        return newProfile
    }
}

// MARK: - 3. Context (Unique State)
// Contains unique data (Extrinsic State) and a reference to the Flyweight.
fileprivate struct ChatMessage {
    let text: String
    let timestamp: Date
    let senderProfile: UserProfileFlyweight // Shared reference
    
    func display() {
        print("[\(timestamp)] \(senderProfile.username): \(text)")
    }
}

/*
 // ==========================================
 // USAGE EXAMPLE
 // ==========================================
 
 let sharedAvatar = UIImage() // Assume a heavy image here
 var chatRoom: [ChatMessage] = []
 
 // Creating 5000 messages from the same two users
 for i in 1...5000 {
    let username = (i % 2 == 0) ? "Berke" : "AI_Assistant"
    
    // The factory ensures only TWO UserProfileFlyweight objects exist in memory.
    let profile = UserProfileFactory.getProfile(username: username, avatar: sharedAvatar)
    
    let message = ChatMessage(text: "Message #\(i)", timestamp: Date(), senderProfile: profile)
    chatRoom.append(message)
 }
 
 print("✅ Total messages: \(chatRoom.count)")
 // Result: 5000 messages created, but only 2 'UserProfileFlyweight' objects stored in RAM.
 */
