//
//  Armored.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 3/1/26.
//

import Foundation

extension ComponentGroups {
    public struct Armored: ComponentGroup {
        public var value: Int
        
        public init(value: Int = 1) {
            self.value = value
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.Armor", [
                "ArmorAmount": [
                    "BaseValue": value,
                ],
            ])
        }
    }
}

extension EnginePieceGroup {
    public typealias Armored = ComponentGroups.Armored
}
