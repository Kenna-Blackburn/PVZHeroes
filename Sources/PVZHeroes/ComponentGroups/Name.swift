//
//  Name.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/23/26.
//

import Foundation

extension ComponentGroups {
    public struct Name: ComponentGroup {
        public var name: String
        
        public init(_ name: String) {
            self.name = name
        }
        
        public var components: [any ComponentGroup] {
            RawComponent { accumulating in
                accumulating.name = name
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Name = ComponentGroups.Name
}
