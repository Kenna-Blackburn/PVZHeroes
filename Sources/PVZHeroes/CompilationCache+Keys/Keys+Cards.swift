//
//  Keys+Cards.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation

extension CompilationCache.Keys {
    public enum Cards: CompilationCache.Key {
        public typealias Value = [Card.Resolved]
        
        public static func reduce(_ newValue: Value, into existingValue: Value) -> Value {
            return existingValue + newValue
        }
    }
}
