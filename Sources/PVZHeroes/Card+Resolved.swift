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
    
    public var `class`: Class
    
    public var set: Set
    public var rarity: Rarity
    public var banner: Banner
    
    public var collectionValue: CollectionValue
    
    public var name: String
    public var description: String
    public var summary: String
    public var flavor: String
    
    public var cost: Int
    public var strength: Int
    public var health: Int
    
    public init(_ accumulating: Accumulating) {
        self.components = accumulating.components
        
        self.guid = accumulating.guid!
        self.prefabID = accumulating.prefabID!
        
        self.faction = accumulating.faction!
        self.kind = accumulating.kind!
        
        self.class = accumulating.class!
        
        self.set = accumulating.set!
        self.rarity = accumulating.rarity!
        self.banner = accumulating.banner!
        
        self.collectionValue = accumulating.collectionValue!
        
        self.name = accumulating.name!
        self.description = accumulating.description!
        self.summary = accumulating.summary!
        self.flavor = accumulating.flavor!
        
        self.cost = accumulating.cost!
        self.strength = accumulating.strength!
        self.health = accumulating.health!
    }
    
    public init(_ base: any Card) {
        self.init(.init(base))
    }
}

extension Card.Resolved {
    public struct Accumulating {
        public var components: [RawComponent]
        
        public var guid: Int?
        public var prefabID: String?
        
        public var faction: Faction?
        public var kind: Kind?
        
        public var `class`: Class?
        
        public var set: Set?
        public var rarity: Rarity?
        public var banner: Banner?
        
        public var collectionValue: CollectionValue?
        
        public var name: String?
        public var description: String?
        public var summary: String?
        public var flavor: String?
        
        public var cost: Int?
        public var strength: Int?
        public var health: Int?
        
        public init() {
            self.components = []
            
            self.guid = nil
            self.prefabID = nil
            
            self.faction = nil
            self.kind = nil
            
            self.class = nil
            
            self.set = nil
            self.rarity = nil
            self.banner = nil
            
            self.collectionValue = nil
            
            self.name = nil
            self.description = nil
            self.summary = nil
            self.flavor = nil
            
            self.cost = nil
            self.strength = nil
            self.health = nil
        }
        
        public init(_ base: any Card) {
            var accumulating = Self()
            base.compile(into: &accumulating)
            self = accumulating
        }
    }
}
