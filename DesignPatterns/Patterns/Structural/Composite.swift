/*
 ----------------------------------------------------------------------------
 PATTERN: Composite
 CATEGORY: Structural
 
 PROBLEM IT SOLVES:
 Allows you to compose objects into tree structures to represent part-whole
 hierarchies. It lets clients treat individual objects and compositions of
 objects uniformly.
 
 SCENARIO:
 File System Hierarchy. A "Folder" can contain "Files" or other "Folders",
 but both respond to the same size and detail requests.
 ----------------------------------------------------------------------------
 */

import Foundation

// MARK: - 1. Component Protocol
fileprivate protocol FileSystemItem {
    var name: String { get }
    func getDetails(indentation: String)
}

// MARK: - 2. Leaf (Individual Object)
fileprivate final class File: FileSystemItem {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getDetails(indentation: String) {
        print("\(indentation)📄 File: \(name)")
    }
}

// MARK: - 3. Composite (Group Object)
fileprivate final class Folder: FileSystemItem {
    let name: String
    private var items: [FileSystemItem] = []
    
    init(name: String) {
        self.name = name
    }
    
    func add(item: FileSystemItem) {
        items.append(item)
    }
    
    func getDetails(indentation: String) {
        print("\(indentation)📂 Folder: \(name)")
        // Delegate the work to children
        for item in items {
            item.getDetails(indentation: indentation + "  ")
        }
    }
}

/*
 // ==========================================
 // USAGE EXAMPLE
 // ==========================================
 
 // 1. Create individual files (Leafs)
 let file1 = File(name: "AppIcon.png")
 let file2 = File(name: "Localizable.strings")
 let file3 = File(name: "AppDelegate.swift")
 
 // 2. Create folders (Composites)
 let resourcesFolder = Folder(name: "Resources")
 resourcesFolder.add(item: file1)
 resourcesFolder.add(item: file2)
 
 let sourceFolder = Folder(name: "Source")
 sourceFolder.add(item: file3)
 
 // 3. Create Root Folder
 let rootProject = Folder(name: "iOS_Project")
 rootProject.add(item: resourcesFolder)
 rootProject.add(item: sourceFolder)
 rootProject.add(item: File(name: "README.md"))
 
 // 4. Uniform Treatment:
 // We treat the entire tree as a single item and call getDetails().
 rootProject.getDetails(indentation: "")
 */
