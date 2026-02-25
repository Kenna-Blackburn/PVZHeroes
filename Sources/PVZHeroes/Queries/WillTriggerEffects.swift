//
//  WillTriggerEffects.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension Queries {
    public struct WillTriggerEffects: Query {
        public var query: RawQuery {
            RawQuery("Queries.WillTriggerEffectsQuery")
        }
    }
}

extension EnginePieceGroup {
    public typealias WillTriggerEffects = Queries.WillTriggerEffects
}
