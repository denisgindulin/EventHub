//
//  DILifecycle.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 28.11.2024.
//


import Foundation

// Define lifecycle types for dependencies
enum DILifecycle {
    case singleton
    case transient
}

// DIKey remains unchanged
enum DIKey {
    case networkService
    case authService
    case storageService
}


// DIService with lifecycle management
final class DIContainer {
    static let shared = DIContainer()
    
    // Dictionary to store dependency factories
    private var factories = [DIKey: (DILifecycle, () -> Any)]()
    
    // Dictionary to store singleton instances
    private var singletons = [DIKey: Any]()
    
    private init() {}
    
    // Register a dependency with a specified lifecycle
    public static func register<T>(_ dependency: @escaping () -> T, forKey key: DIKey, lifecycle: DILifecycle) {
        shared.register(dependency, forKey: key, lifecycle: lifecycle)
    }
    
    // Retrieve a dependency
    public static func resolve<T>(forKey key: DIKey) -> T? {
        return shared.resolve(forKey: key)
    }
    
    // Private method for registering a dependency
    private func register<T>(_ dependency: @escaping () -> T, forKey key: DIKey, lifecycle: DILifecycle) {
        factories[key] = (lifecycle, dependency)
    }
    
    // Private method for retrieving a dependency
    private func resolve<T>(forKey key: DIKey) -> T? {
        // If a singleton already exists, return it
        if let singleton = singletons[key] as? T {
            return singleton
        }
        
        // Check if there's a factory for the dependency
        guard let (lifecycle, factory) = factories[key] else {
            return nil
        }
        
        let instance = factory() as? T
        
        // If the lifecycle is singleton, store the instance for future use
        if lifecycle == .singleton {
            singletons[key] = instance
        }
        
        return instance
    }
}
