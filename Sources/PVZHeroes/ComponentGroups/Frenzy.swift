//
//  Frenzy.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 3/1/26.
//

import Foundation

extension ComponentGroups {
    public struct Frenzy: ComponentGroup {
        public var counters: Counters
        
        public init(counters: Counters = .init()) {
            self.counters = counters
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.Frenzy", [
                "Counters": counters,
            ])
            
            RawComponent { accumulating in
                accumulating.traitIDs.append("Frenzy")
            }
        }
    }
}

extension EnginePieceGroup {
    public typealias Frenzy = ComponentGroups.Frenzy
}
