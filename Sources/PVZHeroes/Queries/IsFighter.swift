//
//  IsFighter.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/28/26.
//

import Foundation

extension Queries {
    public struct IsFighter: Query {
        public var rawQuery: RawQuery {
            RawQuery("Queries.FighterQuery")
        }
    }
}

extension EnginePieceGroup {
    public typealias IsFighter = Queries.IsFighter
}
