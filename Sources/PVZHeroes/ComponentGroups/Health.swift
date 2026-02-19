//
//  Health.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension ComponentGroups {
    public struct Health: ComponentGroup {
        public var health: Int
        
        public init(_ health: Int) {
            self.health = health
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.Health", [
                "HealthValue": [
                    "BaseValue": health,
                ],
                "CurrentDamage": 0,
            ])
            
            RawComponent { resolved in
                resolved.health = health
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Health = ComponentGroups.Health
}
