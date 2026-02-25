//
//  Faction+ComponentGroup.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension Faction: ComponentGroup {
    public init(_ faction: Faction) {
        self = faction
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
    }
}

extension ComponentGroups {
    public typealias Faction = PVZHeroes.Faction
}

extension EnginePieceGroup {
    public typealias Faction = ComponentGroups.Faction
}
