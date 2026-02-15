//
//  CompilationCache.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation

public final class CompilationCache {
    private var cache: [String: Any]
    
    public init() {
        self.cache = [:]
    }
    
    public subscript<T: Key>(_ key: T.Type) -> T.Value? {
        get {
            cache[key.string] as? T.Value
        }
        
        set {
            guard let newValue else {
                return
            }
            
            if let existingValue = self[key] {
                cache[key.string] = key.reduce(newValue, into: existingValue)
            } else {
                cache[key.string] = newValue
            }
        }
    }
}
