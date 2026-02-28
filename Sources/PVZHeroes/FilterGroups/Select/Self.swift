//
//  Self.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/25/26.
//

import Foundation

extension ComponentGroups.Select {
    public struct `Self`: ComponentGroup {
        public var components: [any ComponentGroup] {
            Select.Raw(selectionType: .all) {
                IsSelf()
            }
        }
    }
}
