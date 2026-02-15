//
//  ComponentGroups+GUID.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation

extension ComponentGroups {
    public struct GUID: ComponentGroup {
        public var guid: Int
        
        public init(_ guid: Int) {
            self.guid = guid
        }
        
        public var body: some ComponentGroup {
            RawComponent("Components.Card", [
                "Guid": guid,
            ])
            
            RawComponent { resolved in
                resolved.guid = guid
            }
        }
    }
}

extension ComponentGroup {
    public typealias GUID = ComponentGroups.GUID
}
