//
//  WillTriggerAbilities.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension Queries {
    public struct WillTriggerAbilities: Query {
        public var rawQuery: RawQuery {
            RawQuery("Queries.WillTriggerEffectsQuery")
        }
    }
}

extension EnginePieceGroup {
    public typealias WillTriggerAbilities = Queries.WillTriggerAbilities
}
