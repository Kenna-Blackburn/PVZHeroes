//
//  Faction.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

public enum Faction: String, ComponentGroup {
    case plants = "Plants"
    case zombies = "Zombies"
    case boardAbility = "All"
    
    public init(_ base: Self) {
        self = base
    }
    
    public var components: [any ComponentGroup] {
        switch self {
        case .plants:
            RawComponent("Components.Plants")
        case .zombies:
            RawComponent("Components.Zombies")
        case .boardAbility:
            RawComponent("Components.BoardAbility")
        }
        
        RawComponent { resolved in
            resolved.faction = self
        }
    }
}

extension ComponentGroups {
    public typealias Faction = PVZHeroes.Faction
}

extension EnginePieceGroup {
    public typealias Faction = ComponentGroups.Faction
}

extension Faction {
    public func baseID(for kind: Kind) -> String {
        return kind.baseID(for: self)
    }
}
