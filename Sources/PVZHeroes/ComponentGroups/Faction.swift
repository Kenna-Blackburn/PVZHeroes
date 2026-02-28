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
            RawComponent(faction.componentPartialType)
            
            RawComponent { resolved in
                resolved.faction = faction
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Faction = ComponentGroups.Faction
}

public struct Faction: Equatable, Sendable {
    public var id: String
    public var componentPartialType: String
    
    public init(_ id: String, _ componentPartialType: String) {
        self.id = id
        self.componentPartialType = componentPartialType
    }
}

extension Faction {
    public static let plants: Self = .init("Plants", "Components.Plants")
    public static let zombies: Self = .init("Zombies", "Components.Zombies")
    public static let boardAbility: Self = .init("All", "Components.BoardAbility")
}
