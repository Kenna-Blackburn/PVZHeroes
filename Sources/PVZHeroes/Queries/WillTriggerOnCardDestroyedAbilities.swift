//
//  WillTriggerOnCardDestroyedAbilities.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/28/26.
//

import Foundation

extension Queries {
    public struct WillTriggerOnCardDestroyedAbilities: Query {
        public var rawQuery: RawQuery {
            RawQuery("Queries.WillTriggerOnDeathEffectsQuery")
        }
    }
}

extension EnginePieceGroup {
    public typealias WillTriggerOnCardDestroyedAbilities = Queries.WillTriggerOnCardDestroyedAbilities
}
