//
//  PrefabID.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension ComponentGroups {
    public struct PrefabID: ComponentGroup {
        public var prefabID: String
        
        public init(_ prefabID: String) {
            self.prefabID = prefabID
        }
        
        public var components: [any ComponentGroup] {
            RawComponent { resolved in
                resolved.prefabID = prefabID
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias PrefabID = ComponentGroups.PrefabID
}
