//
//  AnyOf.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation
import Helpers

extension Queries {
    public struct AnyOf: Query {
        public var queries: [any Query]
        
        public init(
            @ArrayBuilder<any Query> _ queries: () -> [any Query],
        ) {
            self.queries = queries()
        }
        
        public var query: RawQuery {
            RawQuery("Queries.CompositeAnyQuery", [
                "queries": queries.compactMap({ $0.query }),
            ])
        }
    }
}

extension EnginePieceGroup {
    public typealias AnyOf = Queries.AnyOf
}
