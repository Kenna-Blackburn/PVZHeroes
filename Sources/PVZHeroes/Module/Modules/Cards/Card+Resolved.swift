//
//  Card+Resolved.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation

extension Card {
    public typealias Resolved = _Card_Resolved
}

public struct _Card_Resolved {
    public var components: [RawComponent]
    
    public var guid: Int
    public var prefabID: String
    
    public var cost: Int
    public var strength: Int
    public var health: Int
    
    public init() {
        self.components = []
        
        self.guid = 0
        self.prefabID = ""
        
        self.cost = 0
        self.strength = 0
        self.health = 0
    }
    
    public init(_ base: any Card) {
        var resolved = Self()
        base.compile(into: &resolved)
        self = resolved
    }
}
