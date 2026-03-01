//
//  GUID.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension ComponentGroups {
    public struct GUID: ComponentGroup {
        public var guid: Int
        
        public init(_ guid: Int) {
            self.guid = guid
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.Card", [
                "Guid": guid,
            ])
            
            RawComponent { accumulating in
                accumulating.guid = guid
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias GUID = ComponentGroups.GUID
}
