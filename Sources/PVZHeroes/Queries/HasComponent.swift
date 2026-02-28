//
//  HasComponent.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/28/26.
//

import Foundation

extension Queries {
    public struct HasComponent: Query {
        public var type: String
        
        public init(_ partialType: String) {
            self.type = RawEnginePiece.type(completing: partialType)
        }
        
        public var rawQuery: RawQuery {
            RawQuery("Queries.HasComponentQuery", [
                "ComponentType": type,
            ])
        }
    }
}

extension EnginePieceGroup {
    public typealias HasComponent = Queries.HasComponent
}
