//
//  UDStorageService.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 29.11.2024.
//

import Foundation

protocol IStorageService {
    func set(value: Any?, forKey key: UDStorageService.Key)
    func getValue(forKey key: UDStorageService.Key) -> Any?
}


final class UDStorageService: IStorageService {
    private let bd = UserDefaults.standard
    
    enum Key: String {
        case hasCompletedOnboarding
    }
    
    func set(value: Any?, forKey key: Key) {
        bd.set(value, forKey: key.rawValue)
    }
    
    func getValue(forKey key: Key) -> Any? {
        return bd.object(forKey: key.rawValue)
    }
    

    func setHasCompletedOnboarding(_ completed: Bool) {
        set(value: completed, forKey: .hasCompletedOnboarding)
    }
    
    func hasCompletedOnboarding() -> Bool {
        return (getValue(forKey: .hasCompletedOnboarding) as? Bool) ?? false
    }
}
