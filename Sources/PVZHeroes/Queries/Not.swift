//
//  Not.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 3/1/26.
//

import Foundation

extension Queries {
    public struct Not: Query {
        public var query: () -> any Query
        
        public init(_ query: @escaping () -> any Query) {
            self.query = query
        }
        
        public var rawQuery: RawQuery {
            RawQuery("Queries.NotQuery", [
                "Query": query().rawQuery,
            ])
        }
    }
}

extension EnginePieceGroup {
    public typealias Not = Queries.Not
}
