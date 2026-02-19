//
//  IsSelf.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension Queries {
    public struct IsSelf: Query {
        public var query: RawQuery {
            RawQuery("Queries.SelfQuery")
        }
    }
}

extension EnginePieceGroup {
    public typealias IsSelf = Queries.IsSelf
}
