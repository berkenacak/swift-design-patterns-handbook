/*
 ----------------------------------------------------------------------------
 PATTERN: Prototype
 CATEGORY: Creational
 
 PROBLEM IT SOLVES:
 Creates new objects by copying (cloning) an existing instance rather than
 building it from scratch.
 
 CRITICAL FOR SWIFT CLASSES:
 In Swift, variables pointing to a Class are "References".
 If you say `let layer2 = layer1`, both variables point to the same object.
 Changing `layer2` destroys `layer1`.
 The Prototype pattern (clone()) solves this by creating a true deep copy.
 
 SCENARIO:
 A Photo/Canvas Editor App. The user selects a "Text Layer" or "Shape"
 and taps "Duplicate". We need an exact copy that is independent of the original.
 ----------------------------------------------------------------------------
 */

import UIKit

// MARK: - 1. The Prototype Interface
// Defines the capability to be cloned.
protocol Copyable {
    // We use 'Self' so adhering types return their own type dynamically
    func clone() -> Self
}

// MARK: - 2. Concrete Prototype (The Complex Object)
// We use 'class' here to demonstrate why Prototype is needed.
// (If this were a struct, copy would be automatic).

class CanvasLayer: Copyable {
    var name: String
    var frame: CGRect
    var opacity: Float
    var filters: [String]
    
    init(name: String, frame: CGRect, opacity: Float, filters: [String]) {
        self.name = name
        self.frame = frame
        self.opacity = opacity
        self.filters = filters
    }
    
    // The Cloning Logic
    func clone() -> Self {
        // We create a BRAND NEW instance using the current properties.
        // This ensures the new object is independent of the old one.
        let copy = CanvasLayer(
            name: "\(self.name) (Copy)", // Auto-rename like Finder
            frame: self.frame.offsetBy(dx: 10, dy: 10), // Offset slightly visually
            opacity: self.opacity,
            filters: self.filters // Array is a struct, so it copies by value automatically
        )
        
        // UnsafeDowncast is needed because init returns specific type, but protocol expects Self
        return copy as! Self
    }
}

// MARK: - 3. The Manager (Client)
// Manages the layers on the screen.

class CanvasViewModel {
    private var layers: [CanvasLayer] = []
    
    func addLayer(_ layer: CanvasLayer) {
        layers.append(layer)
        print("➕ Added: \(layer.name) at \(layer.frame)")
    }
    
    func duplicateLayer(at index: Int) {
        guard index < layers.count else { return }
        
        let originalLayer = layers[index]
        
        // 🚨 WRONG WAY (For Classes):
        // let newLayer = originalLayer
        // newLayer.opacity = 0.5 // This would change the ORIGINAL too!
        
        // ✅ CORRECT WAY (Prototype Pattern):
        let newLayer = originalLayer.clone()
        
        // Now we can modify the copy safely
        newLayer.opacity = 0.5
        
        layers.append(newLayer)
        print("©️ Duplicated: \(newLayer.name) | New Opacity: \(newLayer.opacity) vs Old: \(originalLayer.opacity)")
    }
}

/*
 // ==========================================
 // USAGE EXAMPLE (e.g., inside CanvasViewController)
 // ==========================================
 
 let viewModel = CanvasViewModel()
 
 // 1. Create a complex object (The Prototype)
 let circleLayer = CanvasLayer(
    name: "Red Circle",
    frame: CGRect(x: 0, y: 0, width: 100, height: 100),
    opacity: 1.0,
    filters: ["Shadow", "Blur"]
 )
 
 viewModel.addLayer(circleLayer)
 // Output: ➕ Added: Red Circle...
 
 // 2. User taps "Duplicate" button
 viewModel.duplicateLayer(at: 0)
 // Output: ©️ Duplicated: Red Circle (Copy) | New Opacity: 0.5 vs Old: 1.0
 
 // Proven: Changing the copy did NOT affect the original.
 */
