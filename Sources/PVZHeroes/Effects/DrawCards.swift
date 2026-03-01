//
//  DrawCards.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 3/1/26.
//

import Foundation

extension Effects {
    public struct DrawCards: Effect {
        public var count: Int
        
        public init(_ count: Int = 1) {
            self.count = count
        }
        
        public var rawEffect: RawEffect {
            RawEffect("DrawCardEffectDescriptor", [
                "DrawAmount": count,
            ])
        }
    }
    
    public typealias DrawCard = DrawCards
}

extension EnginePieceGroup {
    public typealias DrawCards = Effects.DrawCards
    public typealias DrawCard = Effects.DrawCard
}
