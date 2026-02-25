//
//  AllOf.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation
import Helpers

extension Queries {
    public struct AllOf: Query {
        public var queries: [any Query]
        
        public init(
            @ArrayBuilder<any Query> _ queries: () -> [any Query],
        ) {
            self.queries = queries()
        }
        
        public var query: RawQuery {
            RawQuery("Queries.CompositeAllQuery", [
                "queries": queries.compactMap({ $0.compile().first }),
            ])
        }
    }
}

extension EnginePieceGroup {
    public typealias AllOf = Queries.AllOf
}
