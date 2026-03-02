//
//  Bullseye.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 3/1/26.
//

import Foundation

extension ComponentGroups {
    public struct Bullseye: ComponentGroup {
        public var counters: Counters
        
        public init(counters: Counters = .init()) {
            self.counters = counters
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.Truestrike", [
                "Counters": counters,
            ])
            
            RawComponent { accumulating in
                accumulating.traitIDs.append("Truestrike")
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Bullseye = ComponentGroups.Bullseye
}
