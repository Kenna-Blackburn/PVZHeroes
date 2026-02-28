//
//  Query.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

public protocol Query: EnginePieceGroup {
    var rawQuery: RawQuery { get }
}

extension Query {
    public func compile() -> [RawEnginePiece] {
        rawQuery.compile()
    }
}

public typealias RawQuery = RawEnginePiece

extension RawQuery: Query {
    public var rawQuery: RawQuery {
        return self
    }
}

public enum Queries {
    
}

extension Never: Query {
    public var rawQuery: RawQuery {
        fatalError()
    }
}
