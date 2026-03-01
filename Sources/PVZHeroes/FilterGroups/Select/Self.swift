//
//  Self.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/25/26.
//

import Foundation

extension ComponentGroups.Select {
    public struct `Self`: ComponentGroup {
        public var ordinal: Raw.Ordinal
        
        public init(ordinal: Raw.Ordinal = .primary) {
            self.ordinal = ordinal
        }
        
        public var components: [any ComponentGroup] {
            Select.Raw(ordinal: ordinal, selectionType: .all) {
                IsSelf()
            }
        }
    }
}
