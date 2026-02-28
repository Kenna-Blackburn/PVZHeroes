//
//  IsInPlay.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/27/26.
//

import Foundation

extension Queries {
    // TODO: rename?
    public struct IsInPlay: Query {
        public var rawQuery: RawQuery {
            RawQuery("Queries.TargetableInPlayFighterQuery")
        }
    }
}

extension EnginePieceGroup {
    public typealias IsInPlay = Queries.IsInPlay
}
