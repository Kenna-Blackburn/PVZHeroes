//
//  IsHero.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 3/1/26.
//

import Foundation

extension Queries {
    public struct IsHero: Query {
        public var faction: Faction
        
        public init(for faction: Faction) {
            self.faction = faction
        }
        
        public var rawQuery: RawQuery {
            AllOf {
                IsOfFaction(faction)
                HasComponent("Components.Player")
            }
            .rawQuery
        }
    }
}

extension EnginePieceGroup {
    public typealias IsHero = Queries.IsHero
}
