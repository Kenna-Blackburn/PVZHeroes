//
//  Cost.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/19/26.
//

import Foundation
extension ComponentGroups {
    public struct Cost: ComponentGroup {
        public var cost: Int
        
        public init(_ cost: Int) {
            self.cost = cost
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.SunCost", [
                "SunCostValue": [
                    "BaseValue": cost,
                ],
            ])
            
            RawComponent { resolved in
                resolved.cost = cost
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Cost = ComponentGroups.Cost
}
