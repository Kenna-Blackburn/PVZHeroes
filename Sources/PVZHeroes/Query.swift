//
//  Query.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

public protocol Query: EnginePieceGroup {
    var query: RawQuery { get }
}

extension Query {
    public func compile() -> [RawEnginePiece] {
        query.compile()
    }
}

public typealias RawQuery = RawEnginePiece

extension RawQuery: Query {
    public var query: RawQuery {
        fatalError()
    }
}

public enum Queries {
    
}

extension Never: Query {
    public var query: RawQuery {
        fatalError()
    }
}
