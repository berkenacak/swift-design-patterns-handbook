# 🏛️ Swift Design Patterns & Principles

> A comprehensive catalog of all **23 GoF (Gang of Four) Design Patterns** and core **Software Engineering Principles** applied in Swift 6.2 for real-world iOS scenarios.

This repository bridges the gap between abstract theory and practical mobile application architecture, focusing on clean, maintainable, and scalable code.

---

## 🧭 Core Principles

We strictly adhere to these philosophies to ensure architectural health:

### 🔹 General Philosophies
* **KISS (Keep It Simple, Stupid):** Avoid complexity. If a simple solution works, don't over-engineer it.
* **DRY (Don't Repeat Yourself):** Abstraction over duplication. Centralize logic to avoid redundancy.
* **YAGNI (You Ain't Gonna Need It):** Don't add functionality until it is necessary.

### 🔹 SOLID Principles
1.  **SRP (Single Responsibility):** A class should have one, and only one, reason to change.
2.  **OCP (Open/Closed):** Entities should be open for extension but closed for modification.
3.  **LSP (Liskov Substitution):** Subtypes must be substitutable for their base types without breaking the app.
4.  **ISP (Interface Segregation):** Clients should not be forced to depend on interfaces they do not use.
5.  **DIP (Dependency Inversion):** Depend on abstractions (Protocols), not on concrete implementations.

---

## 📚 The 23 Design Patterns

### 1. Creational Patterns
*Mechanisms for object creation, optimizing code reusability and flexibility.*

| Pattern | Summary & Real-World Use Case |
| :--- | :--- |
| **Singleton** | Ensures a class has only one instance. **(AuthManager, NetworkService)** |
| **Builder** | Constructs complex objects step-by-step. **(Complex URLRequest, Custom Alerts)** |
| **Factory Method** | Defines an interface for creating objects but lets subclasses decide which class to instantiate. **(Navigation Routing, Screen Factory)** |
| **Abstract Factory** | Creates families of related objects without specifying their concrete classes. **(App Theming: Colors & Fonts)** |
| **Prototype** | Creates new objects by copying an existing one. **(Undo/Redo States, Photo Filters)** |

### 2. Structural Patterns
*How objects and classes are composed to form larger structures.*

| Pattern | Summary & Real-World Use Case |
| :--- | :--- |
| **Adapter** | Allows incompatible interfaces to collaborate. **(Integrating Legacy Models with Modern UI)** |
| **Bridge** | Decouples an abstraction from its implementation. **(Remote Control Logic vs. Device Implementation)** |
| **Composite** | Composes objects into tree structures to represent part-whole hierarchies. **(UIView Hierarchies, File Systems)** |
| **Decorator** | Dynamically adds responsibilities to an object. **(Image Processing Streams, Data Formatting wrappers)** |
| **Facade** | Provides a simplified interface to a complex system. **(Simple API Wrapper for complex Audio/Video Frameworks)** |
| **Flyweight** | Reduces memory usage by sharing common parts of state between objects. **(Caching, Rendering heavy Text/Table Cells)** |
| **Proxy** | Controls access to an object (placeholder). **(Lazy Loading High-Res Images, Access Control)** |

### 3. Behavioral Patterns
*Communication, responsibility, and algorithms between objects.*

| Pattern | Summary & Real-World Use Case |
| :--- | :--- |
| **Chain of Responsibility** | Passes a request along a chain of handlers. **(Responder Chain, Event Logging Systems)** |
| **Command** | Encapsulates a request as an object. **(UI Actions, Transaction Queues)** |
| **Interpreter** | Defines a grammar for instructions and evaluates them. **(Regex Parsers, Math Expression Evaluators)** |
| **Iterator** | Traverses elements of a collection sequentially. **(Custom Data Structures, Playlists)** |
| **Mediator** | Restricts direct communications between objects, forcing them to collaborate via a mediator. **(Coordinator Pattern in Navigation)** |
| **Memento** | Captures and restores an object's internal state. **(Game Saves, Draft Saving)** |
| **Observer** | Notifies multiple objects about any events that happen to the object they're observing. **(KVO, NotificationCenter, Combine)** |
| **State** | Alters an object's behavior when its internal state changes. **(Media Player: Play/Pause/Stop Logic)** |
| **Strategy** | Defines a family of algorithms and makes them interchangeable. **(Sorting Lists, Validation Rules)** |
| **Template Method** | Defines the skeleton of an algorithm in the superclass but lets subclasses override specific steps. **(BaseViewController Lifecycles)** |
| **Visitor** | Separates an algorithm from the objects on which it operates. **(Analytics Reporting on heterogenous View elements)** |

---

## 🚀 Goal
To serve as a "Cheat Sheet" and implementation guide for iOS developers looking to write robust, scalable, and standardized Swift code.

## 🤝 Acknowledgments

* Developed with the assistance of **Google Gemini** and **Anthropic Claude** for architecture planning, documentation refinement, and code example generation.
* Inspired by the classic **Gang of Four (GoF)** design patterns.

Happy Coding!
