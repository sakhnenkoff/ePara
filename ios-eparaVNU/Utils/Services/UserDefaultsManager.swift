//
//  UserDefaultsManager.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 11.04.2022.
//

import Foundation

@propertyWrapper struct Defaults<Value> {
    
    enum DefaultKeys: String {
        case hasOnboarded
    }
    
    let container = UserDefaults.init(suiteName: "AppStorage")
    let key: DefaultKeys
    let defaultValue: Value
    
    var wrappedValue: Value {
        get {
            guard let value = container?.value(forKey: key.rawValue) as? Value else { return defaultValue }
            return value
        }
        
        set {
            container?.set(newValue, forKey: key.rawValue)
        }
    }
    
}

extension UserDefaults {
    @Defaults(key: .hasOnboarded, defaultValue: false) static var hasOnboarded: Bool 
}

extension Defaults where Value == Bool {
    func toggle() {
        var bool = wrappedValue as Bool
        container?.set(bool.toggle(), forKey: key.rawValue)
    }
}

