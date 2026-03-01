//
//  Guard.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/28/26.
//

import Foundation

public enum FilterGroups {
    public struct Guard: FilterGroup {
        public var scope: Scope
        public var query: () -> any Query
        
        public init(_ scope: Scope, query: @escaping () -> any Query) {
            self.scope = scope
            self.query = query
        }
        
        public var filters: [any FilterGroup] {
            RawFilter("Components.\(scope.id)", [
                "Query": query().rawQuery,
            ])
        }
    }
}

extension EnginePieceGroup {
    public typealias Guard = FilterGroups.Guard
}

extension FilterGroups.Guard {
    public struct Scope: Sendable {
        public var id: String
        
        public init(_ id: String) {
            self.id = id
        }
    }
}

extension FilterGroups.Guard.Scope {
    public static let triggerSource: Self = .init("TriggerSourceFilter")
    public static let triggerTarget: Self = .init("TriggerTargetFilter")
    
    // TODO: rename to avoid backticks
    public static let `self`: Self = .init("SelfEntityFilter")
}
