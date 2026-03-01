//
//  ArrayBuilder.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/13/26.
//

import Foundation

@resultBuilder
public enum ArrayBuilder<Element> {
    public static func buildExpression(_ void: Void) -> [Element] {
        return []
    }
    
    public static func buildExpression(_ element: Element) -> [Element] {
        return [element]
    }
    
    public static func buildExpression(_ array: [Element]) -> [Element] {
        return array
    }
    
    public static func buildBlock(_ arrays: [Element]...) -> [Element] {
        return buildArray(arrays)
    }
    
    public static func buildArray(_ arrays: [[Element]]) -> [Element] {
        return arrays.flatMap({ $0 })
    }
    
    public static func buildOptional(_ array: [Element]?) -> [Element] {
        return array ?? []
    }
    
    public static func buildEither(first array: [Element]) -> [Element] {
        return array
    }
    
    public static func buildEither(second array: [Element]) -> [Element] {
        return array
    }
}

extension Array {
    public init(
        @ArrayBuilder<Element> _ build: () -> [Element]
    ) {
        self = build()
    }
}
