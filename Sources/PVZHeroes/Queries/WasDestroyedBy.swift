//
//  WasDestroyedBy.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/28/26.
//

import Foundation

extension Queries {
    public struct WasDestroyedBy: Query {
        public var query: () -> any Query
        
        public init(_ query: @escaping () -> any Query) {
            self.query = query
        }
        
        public var rawQuery: RawQuery {
            RawQuery("Queries.KilledByQuery", [
                "Query": query().rawQuery,
            ])
        }
    }
}

extension EnginePieceGroup {
    public typealias WasDestroyedBy = Queries.WasDestroyedBy
}
