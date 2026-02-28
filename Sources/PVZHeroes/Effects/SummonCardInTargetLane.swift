//
//  SummonCardInTargetLane.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/28/26.
//

import Foundation

extension Effects {
    public struct SummonCardInTargetLane: ComponentGroup {
        public var guid: Int
        public var shouldPlaceInGravestone: Bool
        
        init(_ guid: Int, shouldPlaceInGravestone: Bool = false) {
            self.guid = guid
            self.shouldPlaceInGravestone = shouldPlaceInGravestone
        }
        
        public var components: [any ComponentGroup] {
            RawComponent("Components.CreateCardEffectDescriptor", [
                "CardGuid": guid,
                "ForceFaceDown": shouldPlaceInGravestone,
            ])
        }
    }
}

extension EnginePieceGroup {
    public typealias SummonCardInTargetLane = Effects.SummonCardInTargetLane
}
