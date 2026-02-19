//
//  ApplyBuff.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension ComponentGroups {
    public struct ApplyBuff: ComponentGroup {
        public var strength: Int
        public var health: Int
        public var duration: Duration
        
        public init(_ strength: Int, _ health: Int, duration: Duration = .indefinite) {
            self.strength = strength
            self.health = health
            self.duration = duration
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.BuffEffectDescriptor", [
                "AttackAmount": strength,
                "HealthAmount": health,
                "Duration": duration,
            ])
        }
        
        public enum Duration: String, Encodable {
            case indefinite = "Permanent"
            case untilEndOfTurn = "EndOfTurn"
        }
    }
}

extension EnginePieceGroup {
    public typealias ApplyBuff = ComponentGroups.ApplyBuff
}
