//
//  HealthAttack.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation

extension ComponentGroups {
    public struct HealthAttack: ComponentGroup {
        public var counters: Counters
        
        public init(counters: Counters = .init(counters: [.init(value: 2)])) {
            self.counters = counters
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.AttackOverride", [
                "Counters": counters,
            ])
        }
    }
}

extension EnginePieceGroup {
    public typealias HealthAttack = ComponentGroups.HealthAttack
}
