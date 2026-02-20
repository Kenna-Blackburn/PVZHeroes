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
                "queries": queries.compactMap({ $0.compile().first }),
            ])
        }
    }
}

extension EnginePieceGroup {
    public typealias AnyOf = Queries.AnyOf
}

extension Array<any Query> {
    // TODO: dry; see AllOf.swift
    public func compositeAny() -> any Query {
        guard let first = self.first else {
            return Queries.AnyOf({ return [] })
        }
        
        guard self.count > 1 else {
            return first
        }
        
        return Queries.AnyOf({ return self })
    }
}
