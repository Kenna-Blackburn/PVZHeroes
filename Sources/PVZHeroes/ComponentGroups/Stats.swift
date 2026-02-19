//
//  Stats.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension ComponentGroups {
    public struct Stats: ComponentGroup {
        public var strength: Int
        public var health: Int
        
        public init(_ strength: Int, _ health: Int) {
            self.strength = strength
            self.health = health
        }
        
        public var components: [any ComponentGroup] {
            Strength(strength)
            Health(health)
        }
    }
}

extension EnginePieceGroup {
    public typealias Stats = ComponentGroups.Stats
}
