//
//  IsAlive.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension Queries {
    public struct IsAlive: Query {
        public var rawQuery: RawQuery {
            RawQuery("Queries.IsAliveQuery")
        }
    }
}

extension EnginePieceGroup {
    public typealias IsAlive = Queries.IsAlive
}
