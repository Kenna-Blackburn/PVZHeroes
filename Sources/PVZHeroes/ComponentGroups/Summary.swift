//
//  Summary.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/23/26.
//

import Foundation

extension ComponentGroups {
    public struct Summary: ComponentGroup {
        public var summary: String
        
        public init(_ summary: String) {
            self.summary = summary
        }
        
        public var components: [any ComponentGroup] {
            RawComponent { resolved in
                resolved.summary = summary
                
                if resolved.description.isEmpty {
                    resolved.description = summary
                }
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Summary = ComponentGroups.Summary
}
