//
//  Flavor.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/23/26.
//

import Foundation

extension ComponentGroups {
    public struct Flavor: ComponentGroup {
        public var flavor: String
        
        public init(_ flavor: String) {
            self.flavor = flavor
        }
        
        public var components: [any ComponentGroup] {
            RawComponent { resolved in
                resolved.flavor = flavor
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Flavor = ComponentGroups.Flavor
}
