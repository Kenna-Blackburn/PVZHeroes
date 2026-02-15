//
//  ComponentGroups+PrefabID.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/14/26.
//

import Foundation

extension ComponentGroups {
    public struct PrefabID: ComponentGroup {
        public var prefabID: String
        
        public init(_ prefabID: String) {
            self.prefabID = prefabID
        }
        
        public var body: some ComponentGroup {
            RawComponent { resolved in
                resolved.prefabID = prefabID
            }
        }
    }
}

extension Card {
    public typealias PrefabID = ComponentGroups.PrefabID
}
