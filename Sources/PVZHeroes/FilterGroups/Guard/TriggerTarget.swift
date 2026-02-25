//
//  TriggerTarget.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation
import Helpers

extension FilterGroups.Guard {
    // TODO: rename?
    public struct TriggerTarget: FilterGroup {
        public var query: any Query
        
        public init(_ query: () -> any Query) {
            self.query = query()
        }
        
        public var filters: [any FilterGroup] {
            RawFilter("Components.TriggerTargetFilter", [
                "Query": query.compile().first!,
            ])
        }
    }
}
