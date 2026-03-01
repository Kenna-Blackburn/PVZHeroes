//
//  IsOfFaction.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 3/1/26.
//

import Foundation

extension Queries {
    public struct IsOfFaction: Query {
        public var faction: Faction
        
        public init(_ faction: Faction) {
            self.faction = faction
        }
        
        public var rawQuery: RawQuery {
            HasComponent {
                Faction(faction)
            }
            .rawQuery
        }
    }
}

extension EnginePieceGroup {
    public typealias IsOfFaction = Queries.IsOfFaction
}
