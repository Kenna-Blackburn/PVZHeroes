//
//  Strength.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension ComponentGroups {
    public struct Strength: ComponentGroup {
        public var strength: Int
        
        public init(_ strength: Int) {
            self.strength = strength
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.Attack", [
                "AttackValue": [
                    "BaseValue": strength,
                ],
            ])
            
            RawComponent { resolved in
                resolved.strength = strength
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Strength = ComponentGroups.Strength
}
