//
//  Description.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/23/26.
//

import Foundation

extension ComponentGroups {
    public struct Description: ComponentGroup {
        public var description: String
        
        public init(_ description: String) {
            self.description = description
        }
        
        public var components: [any ComponentGroup] {
            RawComponent { resolved in
                resolved.description = description
                
                if resolved.summary.isEmpty {
                    resolved.summary = description
                }
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Description = ComponentGroups.Description
}
