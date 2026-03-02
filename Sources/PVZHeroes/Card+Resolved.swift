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
    public var _sourceString: String
    
    public var components: [RawComponent]
    public var traitIDs: [String]
    
    public var guid: Int
    public var prefabID: String
    
    public var faction: Faction
    public var kind: Kind
    
    public var `class`: Class
    
    public var set: Set
    public var rarity: Rarity
    public var banner: Banner
    
    public var tribes: [Tribe]
    public var tags: [Tag]
    
    public var collectionValue: CollectionValue
    
    public var name: String
    public var description: String
    public var summary: String
    public var flavor: String
    
    public var cost: Int
    public var strength: Int
    public var health: Int
    
    public init(_ accumulating: Accumulating) {
        // TODO: rename
        func helper<T>(
            _ keyPath: KeyPath<Card.Resolved.Accumulating, T?>,
            _ label: String,
            _ fallback: T,
        ) -> T {
            if let value = accumulating[keyPath: keyPath] {
                return value
            } else {
                print("'\(accumulating._sourceString)' is missing a '\(label)'. Falling back to '\(fallback)'.")
                return fallback
            }
        }
        
        self._sourceString = accumulating._sourceString
        
        self.components = accumulating.components
        self.traitIDs = accumulating.traitIDs
        
        self.guid = helper(\.guid, "GUID", 0)
        self.prefabID = helper(\.prefabID, "PrefabID", "")
        
        self.faction = helper(\.faction, "Faction", .boardAbility)
        self.kind = helper(\.kind, "Kind", .trick)
        
        self.class = helper(\.class, "Class", .none)
        
        self.set = helper(\.set, "Set", .basic)
        self.rarity = helper(\.rarity, "Rarity", .common)
        self.banner = helper(\.banner, "Banner", .basicCommon)
        
        self.tribes = helper(\.tribes, "Tribes", [])
        self.tags = helper(\.tags, "Tags", [])
        
        self.collectionValue = helper(\.collectionValue, "CollectionValue", .common)
        
        self.name = helper(\.name, "Name", "")
        self.description = helper(\.description, "Description", "")
        self.summary = helper(\.summary, "Summary", "")
        self.flavor = helper(\.flavor, "Flavor", "")
        
        self.cost = helper(\.cost, "Cost", 0)
        self.strength = helper(\.strength, "Strength", 0)
        self.health = helper(\.health, "Health", 0)
    }
    
    public init(_ base: any Card) {
        self.init(.init(base))
    }
}

extension Card.Resolved {
    public struct Accumulating {
        public var _sourceString: String
        
        public var components: [RawComponent]
        public var traitIDs: [String]
        
        public var guid: Int?
        public var prefabID: String?
        
        public var faction: Faction?
        public var kind: Kind?
        
        public var `class`: Class?
        
        public var set: Set?
        public var rarity: Rarity?
        public var banner: Banner?
        
        public var tribes: [Tribe]?
        public var tags: [Tag]?
        
        public var collectionValue: CollectionValue?
        
        public var name: String?
        public var description: String?
        public var summary: String?
        public var flavor: String?
        
        public var cost: Int?
        public var strength: Int?
        public var health: Int?
        
        public init(_ sourceString: String) {
            self._sourceString = sourceString
            
            self.components = []
            self.traitIDs = []
            
            self.guid = nil
            self.prefabID = nil
            
            self.faction = nil
            self.kind = nil
            
            self.class = nil
            
            self.set = nil
            self.rarity = nil
            self.banner = nil
            
            self.tribes = nil
            self.tags = nil
            
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
            var accumulating = Self(String(describing: type(of: base)))
            base.compile(into: &accumulating)
            self = accumulating
        }
    }
}
