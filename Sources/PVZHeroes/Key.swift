//
//  Key.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation

extension CompilationCache {
    public protocol Key {
        associatedtype Value
        
        static var string: String { get }
        
        static func reduce(_ newValue: Value, into existingValue: Value) -> Value
    }
}

extension CompilationCache.Key {
    public static var string: String {
        String(reflecting: Self.self)
    }
}

extension CompilationCache {
    public enum Keys {}
}
