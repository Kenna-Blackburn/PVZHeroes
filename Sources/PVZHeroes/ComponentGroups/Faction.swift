//
//  Faction.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension ComponentGroups {
    public struct Faction: ComponentGroup {
        public var faction: PVZHeroes.Faction
        
        public init(_ faction: PVZHeroes.Faction) {
            self.faction = faction
        }
        
        public var components: [any ComponentGroup] {
            switch faction {
            case .plants:
                RawComponent("Components.Plants")
            case .zombies:
                RawComponent("Components.Zombies")
            case .boardAbility:
                RawComponent("Components.BoardAbility")
            }
            
            RawComponent { resolved in
                resolved.faction = faction
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Faction = ComponentGroups.Faction
}

public enum Faction: String {
    case plants = "Plants"
    case zombies = "Zombies"
    case boardAbility = "All"
}
