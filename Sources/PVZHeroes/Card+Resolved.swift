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
    
    public var faction: Faction
    public var kind: Kind
    
    // TODO: use Optionals?
    // TODO: rename to avoid backticks?
    public var `class`: Class
    public var set: Set
    public var rarity: Rarity
    public var banner: Banner
    
    public var name: String
    public var description: String
    public var summary: String
    public var flavor: String
    
    public var cost: Int
    public var strength: Int
    public var health: Int
    
    public init() {
        self.components = []
        
        self.guid = 0
        self.prefabID = ""
        
        self.faction = .boardAbility
        self.kind = .trick
        
        self.class = .none
        self.set = .blank
        self.rarity = .common
        self.banner = .none
        
        self.name = ""
        self.description = ""
        self.summary = ""
        self.flavor = ""
        
        self.cost = 0
        self.strength = 0
        self.health = 0
    }
    
    public init(_ base: any Card) {
        var resolved = Self()
        base.compile().forEach({ $0.compile(into: &resolved) })
        self = resolved
    }
}
